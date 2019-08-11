//
//  WordsViewModel.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 07/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation
import Combine

class WordsViewModel {
    
    // MARK: - Constants and Enums

    private struct Constants {
        static let totalTime: Int = 299
    }
    
    enum State: String {
        case start, reset
        
        var alias: String {
            switch self {
            case .start: return "Start"
            case .reset: return "Reset"
            }
        }
    }
    
    // MARK: - Typealias

    typealias WordsQuiz = Question
    typealias GameResult = (title: String, message: String, action: String)
    
    // MARK: - Publishers Properties

    @Published var quiz: WordsQuiz? = nil {
        didSet {
            guard let quiz = quiz else { return }
            wordsCount = "\(typedWords.count)/\(quiz.words.count)"
        }
    }
    
    @Published var typedWords: [String] = [] {
        didSet {
            guard let quiz = quiz else { return }
            wordsCount = "\(typedWords.count)/\(quiz.words.count)"
        }
    }
    
    @Published var timeRemaining: String? = "-:-"
    @Published var wordsCount: String? = "-/-"
    @Published var currentState: State = .start
    @Published var gameResult: GameResult? = nil
    
    // MARK: - Properties

    var countdownTimer: Timer?
    var totalTime: Int = Constants.totalTime
    let service: QuizService
    
    // MARK: - Initializers
    
    init() {
        self.service = QuizService()
    }
    
    // MARK: - Life Cycle

    /// Life cycle function to load the words from API and configurate whe words count property.
    ///
    func viewWillAppear() {
        fetchWords()
        guard let quiz = quiz else { return }
        wordsCount = "\(typedWords.count)/\(quiz.words.count)"
    }
    
    // MARK: - Methods

    /// Calls service to fetch the words from Arc Touch API.
    ///
    func fetchWords() {
        service.retrieveQuizWords(completion: { result in
            switch result {
            case .success(let response):
                self.quiz = response
            case .failure(let error):
                NSLog("Oops! There's an error: %@", error.message)
            }
        })
    }
    
    /// Based on quiz words returned via API Service, verifies if the typed word matches with the API words list and adds it to typedWords property.
    ///
    /// - Parameter word: Typed word from view.
    /// - Returns: A Boolean value telling if the word is correct or incorrect
    func userIsTypingWord(word: String) -> Bool {
        guard let quiz = quiz else { return false }
        if (quiz.words.contains(word) && !typedWords.contains(word)) {
            typedWords.append(word)
            if (typedWords.count == quiz.words.count) {
                gameResult = ("Congratulations", "Good job! You found all the answers on time. Keep up with the great work.", "Play Again")
            }
            return true
        }
        return false
    }
    
    /// Erases the typed words, sets the current state and starts or resets the timer depending on it's value.
    ///
    func userTappedStartButton() {
        currentState = currentState == .start ? .reset : .start
        typedWords = []
        if currentState == .start{
            resetTimer()
        } else {
             startTimer()
        }
    }
    
    /// Resets the game erasing the typed words, changin the current state and re-starting the timer.
    ///
    func reset() {
        typedWords = []
        currentState = currentState == .start ? .reset : .start
        if let countdownTimer = countdownTimer {
            countdownTimer.invalidate()
            startTimer()
        }
    }
    
    /// Resets the timer and the time remaining formatted string.
    ///
    func resetTimer() {
        if let countdownTimer = countdownTimer {
            countdownTimer.invalidate()
            totalTime = Constants.totalTime
            timeRemaining = "00:00"
        }
    }
    
    /// Sets the total time constant to the counter and starts the timer countdown
    ///
    func startTimer() {
        totalTime = Constants.totalTime
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    /// Updates the total time property and the time remaning formatted string.
    ///
    @objc func updateTimer() {
        timeRemaining = totalTime.formattedTime
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    
    /// Ends the timer and triggers an alert using the subscriber to tell the user that the game is over due the time out.
    ///
    func endTimer() {
        guard let countdownTimer = countdownTimer else { return }
        countdownTimer.invalidate()
        currentState = .start
        guard let quiz = quiz else { return }
        gameResult = ("Time finished", "Sorry, time is up! You got \(typedWords.count) out of \(quiz.words.count) answers.", "Try Again")
    }
    
}
