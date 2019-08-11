//
//  TestsQuizViewModel.swift
//  AT_Java_KeywordsTests
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import XCTest
@testable import AT_Java_Keywords

class WordsViewModelTests: XCTestCase {

    private var viewModel: WordsViewModel!
    
    override func setUp() {
        viewModel = WordsViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testFetchWords() {
        // Given
        XCTAssertEqual(viewModel.wordsCount, "-/-")
        let expectation = self.expectation(description: #function)
        
        // When
        viewModel.fetchWords()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        //Then
        XCTAssertEqual(viewModel.wordsCount, "0/50")
        
    }
    
    func testViewWillAppear() {
        // Given
        XCTAssertEqual(viewModel.wordsCount, "-/-")
        let expectation = self.expectation(description: #function)
        
        // When
        viewModel.viewWillAppear()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        //Then
        XCTAssertEqual(viewModel.wordsCount, "0/50")
        
    }
    
    func testUserIsTypingWordSuccess() {
        // Given
        let expectation = self.expectation(description: #function)
        
        // When
        viewModel.fetchWords()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        let result = viewModel.userIsTypingWord(word: "boolean")
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testUserIsTypingWordFail() {
        // Given
        let expectation = self.expectation(description: #function)
        
        // When
        viewModel.fetchWords()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        let result = viewModel.userIsTypingWord(word: "b00l3an")
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testUserTappedStartButton() {
        // Given
        XCTAssertEqual(viewModel.currentState, WordsViewModel.State.start)
        
        // When
        viewModel.userTappedStartButton()
        
        // Then
        XCTAssertEqual(viewModel.currentState, WordsViewModel.State.reset)
        XCTAssertEqual(viewModel.typedWords, [])
        
    }
    
    func testReset() {
        // Given
        
        // When
        viewModel.reset()
        
        // Then
        XCTAssertEqual(viewModel.typedWords, [])
        XCTAssertTrue(viewModel.totalTime > 0)
        XCTAssertEqual(viewModel.currentState, WordsViewModel.State.reset)
    }
    
    func testResetTimer() {
        // Given
        
        // When
        viewModel.startTimer()
        viewModel.resetTimer()
        
        // Then
        XCTAssertEqual(viewModel.totalTime, 300)
        XCTAssertEqual(viewModel.timeRemaining, "00:00")
        
    }
    
    func testStarTimer() {
        // Given
        XCTAssertNil(viewModel.countdownTimer)
        
        // When
        viewModel.startTimer()
        
        // Then
        XCTAssertNotNil(viewModel.countdownTimer)
    }
    
    func testUpdateTimer() {
        // Given
        XCTAssertEqual(viewModel.timeRemaining, "-:-")
        let expectation = self.expectation(description: #function)
        
        // When
        viewModel.startTimer()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Then
        XCTAssertEqual(viewModel.timeRemaining, "04:55")
        XCTAssertEqual(viewModel.totalTime, 294)
        
    }
    
    func testEndTimer() {
        // Given
        let expectation = self.expectation(description: #function)
        
        // When
        viewModel.fetchWords()
        viewModel.startTimer()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        viewModel.endTimer()
        
        // Then
        XCTAssertEqual(viewModel.gameResult?.message, "Sorry, time is up! You got 0 out of 50 answers.")
    }
    

}
