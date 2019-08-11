//
//  QuizFlowController.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 07/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation
import UIKit

public class QuizFlowController {
    
    // MARK: - PRIVATE PROPERTIES
    private let quizFactory: QuizFactory
    
    // MARK: - INITIALIZERS
    init(navigationController: UINavigationController, quizFactory: QuizFactory) {
        self.navigationController = navigationController
        self.quizFactory = quizFactory
    }
    
    // MARK: - PUBLIC API
    
    
    /// Quiz Navigation Controller. This navigation holds all internal UIViewControllers
    /// That will be stack over the Quiz execution.
    let navigationController: UINavigationController

    /// A Quiz flow controller delegate
    weak var delegate: QuizFlowControllerDelegate?
    
    func start() {
        let wordsViewController = quizFactory.makeWordsQuiz()
        navigationController.pushViewController(wordsViewController, animated: true)
    }

}
