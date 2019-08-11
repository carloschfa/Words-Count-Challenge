//
//  WordsViewControllerTests.swift
//  AT_Java_KeywordsTests
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import XCTest
@testable import AT_Java_Keywords

class WordsViewControllerTests: XCTestCase {
    
    private var viewController: WordsViewController!
    private var viewModel: WordsViewModel!
    
    override func setUp() {
        viewModel = WordsViewModel()
        viewController = WordsViewController(viewModel: viewModel)
    }
    
    override class func tearDown() {
        
    }
    
    func testInit() {
        // Given
        let viewModelUT = WordsViewModel()
        let viewControllerUT: WordsViewController?
        
        // When
        viewControllerUT = WordsViewController.init(viewModel: viewModelUT)
        
        // Then
        XCTAssertNotNil(viewControllerUT)
        XCTAssertNotNil(viewControllerUT?.viewModel)
    }
    
    func testBind() {
        // Given
        
        // When
        viewController.bind()
        
        // Then
        XCTAssertNotNil(viewController.quizSubscriber)
        XCTAssertNotNil(viewController.typedWordsSubscriber)
        XCTAssertNotNil(viewController.stateSubscriber)
        XCTAssertNotNil(viewController.wordsCountSubscriber)
        XCTAssertNotNil(viewController.gameResultSubscriber)
    }
    
    
    
}
