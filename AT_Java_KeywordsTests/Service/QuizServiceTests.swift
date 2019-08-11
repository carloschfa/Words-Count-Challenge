//
//  QuizServiceTests.swift
//  AT_Java_KeywordsTests
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import XCTest
@testable import AT_Java_Keywords

class QuizServiceTests: XCTestCase {
    
    override class func setUp() {
        
    }
    
    func testRetrieveQuizWords() {
        // Given
        let service = QuizService()
        let expectation = self.expectation(description: #function)
        var result: Question?
        
        // When
        service.retrieveQuizWords(completion: { value in
            switch value {
            case .success(let response):
                result = response
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.message)
            }
        })
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(result)
        
    }
    
}
