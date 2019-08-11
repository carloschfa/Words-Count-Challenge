//
//  QuizFactory.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 07/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

protocol QuizFactory {
    
    /// Builds a WordsViewController
    ///
    /// - Returns: An instantiated WordsViewController
    func makeWordsQuiz() -> WordsViewController
    
}
