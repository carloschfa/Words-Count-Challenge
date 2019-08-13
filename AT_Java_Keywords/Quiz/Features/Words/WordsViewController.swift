//
//  ViewController.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 06/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import UIKit
import Combine

class WordsViewController: UIViewController {
    
    // MARK: - UI

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var quizTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.words.largeTitle.font
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor.words.darkGray.color
        textfield.font = UIFont.words.body.font
        textfield.layer.cornerRadius = 10
        textfield.clipsToBounds = true
        textfield.placeholder = "Insert Word"
        textfield.isEnabled = false
        textfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textfield.setLeftPaddingPoints(10)
        return textfield
    }()
    
    lazy var wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.words.gray.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var typedWordsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.words.largeTitle.font
        return label
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.words.largeTitle.font
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.words.orange.color
        button.titleLabel?.font = UIFont.words.button.font
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Properties and Subscribers Properties

    var viewModel: WordsViewModel
    var timeRemainingSubscriber: AnyCancellable?
    var quizSubscriber: AnyCancellable?
    var typedWordsSubscriber: AnyCancellable?
    var stateSubscriber: AnyCancellable?
    var wordsCountSubscriber: AnyCancellable?
    var gameResultSubscriber: AnyCancellable?
    var errorSubscriber: AnyCancellable?
    var keyboardHeight: CGFloat?
    var bottomViewYPosition: CGFloat?
    
    // MARK: - Initializers

    init(viewModel: WordsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        addSubviews()
        setConstraints()
        setBottomViewConstraints()
        self.showSpinner(onView: self.view)
        bind()
        viewModel.viewWillAppear()
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        view.endEditing(true)
        self.keyboardHeight = nil
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // MARK: - Methods

    /// Binds the subscribers with the view model publishers
    ///
    func bind() {
        quizSubscriber = viewModel.$quiz.receive(on: DispatchQueue.main).sink { quiz in
            guard let quiz = quiz else { return }
            self.removeSpinner()
            self.quizTitle.text = quiz.question
        }
        
        typedWordsSubscriber = viewModel.$typedWords.receive(on: DispatchQueue.main).sink { typedWords in
            self.wordsTableView.reloadData()
        }
        
        wordsCountSubscriber = viewModel.$wordsCount.receive(on: DispatchQueue.main).assign(to: \.text, on: typedWordsCountLabel)
        
        timeRemainingSubscriber = viewModel.$timeRemaining.receive(on: DispatchQueue.main).assign(to: \.text, on: timerLabel)
        
        stateSubscriber = viewModel.$currentState.receive(on: DispatchQueue.main).sink { state in
            self.searchTextField.text = ""
            if (state == .start) {
                self.searchTextField.isEnabled = false
            } else {
                self.searchTextField.isEnabled = true
                self.searchTextField.becomeFirstResponder()
            }
            self.startButton.setTitle(state.alias, for: .normal)
        }
        
        gameResultSubscriber = viewModel.$gameResult.receive(on: DispatchQueue.main).sink { result in
            guard let result = result else { return }
            self.showMessage(title: result.title, message: result.message, action: result.action)
        }
        
        errorSubscriber = viewModel.$serviceError.receive(on: DispatchQueue.main).sink {
            error in
            if error != nil {
                self.removeSpinner()
                self.showErrorMessage(error: error?.message)
            }
        }
    }
    
    // MARK: - Private Methods
    
    @objc private func textFieldDidChange() {
        guard let word = searchTextField.text?.lowercased() else { return }
        let result = viewModel.userIsTypingWord(word: word)
        if (result) {
            searchTextField.text = ""
        }
    }
    
    @objc private func buttonWasTapped() {
        viewModel.userTappedStartButton()
    }
    
    /// Show an message based on the return of gameResult publisher from view model.
    ///
    private func showMessage(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
            self.viewModel.reset()
        }))
        self.present(alert, animated: true)
    }
    
    private func showErrorMessage(error: String?) {
        let alert = UIAlertController(title: "Oops! There's an error.", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.viewModel.fetchWords()
        }))
        self.present(alert, animated: true)
    }
    
}

// MARK: - Extensions

extension WordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.typedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WordsTableViewCell()
        cell.selectionStyle = .none
        cell.configure(word: viewModel.typedWords[indexPath.row])
        return cell
    }
}
