//
//  WordsViewController+View.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import UIKit

extension WordsViewController {
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(quizTitle)
        contentView.addSubview(searchTextField)
        contentView.addSubview(wordsTableView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(typedWordsCountLabel)
        bottomView.addSubview(timerLabel)
        bottomView.addSubview(startButton)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            quizTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: WordsConstants.quizTitleTopAnchor),
            quizTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: WordsConstants.quizTitleLeadingAnchor),
            quizTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: WordsConstants.quizTitleTrailingAnchor),
            
            searchTextField.heightAnchor.constraint(equalToConstant: WordsConstants.searchTextFieldHeight),
            searchTextField.topAnchor.constraint(equalTo: quizTitle.bottomAnchor, constant: WordsConstants.searchTextFieldTopAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: WordsConstants.searchTextFieldLeadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: WordsConstants.searchTextFieldTrailingAnchor),
            
            wordsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            wordsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WordsConstants.wordsTableViewLeadingAnchor),
            wordsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: WordsConstants.wordsTableViewTrailingAnchor),
            wordsTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.topAnchor.constraint(equalTo: wordsTableView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: WordsConstants.bottomViewHeightAnchor),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func setBottomViewConstraints() {
        NSLayoutConstraint.activate([
            typedWordsCountLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: WordsConstants.typedWordsCountLabelTopAnchor),
            typedWordsCountLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: WordsConstants.typedWordsCountLabelLeadingAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: WordsConstants.timerLabelTopAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: WordsConstants.timerLabelTrailingAnchor),
            
            startButton.heightAnchor.constraint(equalToConstant: WordsConstants.startButtonHeightAnchor),
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: WordsConstants.startButtonTopAnchor),
            startButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: WordsConstants.startButtonLeadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: WordsConstants.startButtonTrailingAnchor)
            ])
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.bottomViewYPosition == nil {
                self.bottomViewYPosition = self.bottomView.frame.origin.y
            }
            if self.keyboardHeight == nil {
                if UIDevice.current.orientation.isLandscape {
                    self.keyboardHeight = keyboardSize.height / 2
                } else if UIDevice.current.orientation.isPortrait {
                    self.keyboardHeight = keyboardSize.height
                }
            }
            guard let keyboardHeight = self.keyboardHeight else { return }
            self.bottomView.frame.origin.y -= keyboardHeight
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        guard let bottomViewYPosition = self.bottomViewYPosition else { return }
        self.bottomView.frame.origin.y = bottomViewYPosition
    }
    
}
