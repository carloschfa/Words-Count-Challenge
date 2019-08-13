//
//  DomainTests.swift
//  AT_Java_KeywordsTests
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import XCTest
@testable import AT_Java_Keywords

class DomainTests: XCTestCase {
    
    var serviceError: ServiceError!
    
    override class func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testGetInvalidMessage() {
        // Given
        serviceError = ServiceError.invalid("Error for testing.")
        
        // Then
        XCTAssertEqual(serviceError.message, "Error for testing.")
    }
    
    func testBlockedMessage() {
        // Given
        serviceError = ServiceError.blocked("Error for testing.")
        
        // Then
        XCTAssertEqual(serviceError.message, "Error for testing.")
        
    }
    
    func testUnauthorizedMessage() {
        // Given
        serviceError = ServiceError.unauthorized("Error for testing.")
        
        // Then
        XCTAssertEqual(serviceError.message, "Error for testing.")
        
    }
    
}
