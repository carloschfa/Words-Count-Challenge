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
        view.addSubview(quizTitle)
        view.addSubview(searchTextField)
        view.addSubview(wordsTableView)
        view.addSubview(bottomView)
        bottomView.addSubview(typedWordsCountLabel)
        bottomView.addSubview(timerLabel)
        bottomView.addSubview(startButton)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            
            quizTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            quizTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quizTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchTextField.heightAnchor.constraint(equalToConstant: 54),
            searchTextField.topAnchor.constraint(equalTo: quizTitle.bottomAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            wordsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            wordsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            wordsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            wordsTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.topAnchor.constraint(equalTo: wordsTableView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 140),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func setBottomViewConstraints() {
        NSLayoutConstraint.activate([
            typedWordsCountLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            typedWordsCountLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            
            timerLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 16),
            startButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            
            ])
    }
    
}
