//
//  AppDelegateTests.swift
//  AT_Java_KeywordsTests
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import XCTest
@testable import AT_Java_Keywords

class AppDelegateTests: XCTestCase {
    
    override class func setUp() {
        
    }
    
    func testMakeWordsQuiz() {
        // Given
        let appDelegate = AppDelegate()
        let viewController: WordsViewController?
        
        // When
        viewController = appDelegate.makeWordsQuiz()
        
        // Then
        XCTAssertNotNil(viewController)
        
    }
    
}
