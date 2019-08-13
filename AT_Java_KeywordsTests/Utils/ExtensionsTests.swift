//
//  ExtensionsTests.swift
//  AT_Java_KeywordsTests
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import XCTest
@testable import AT_Java_Keywords

class ExtensionsTests: XCTestCase {
    
    override class func setUp() {
        
    }
    
    func testNSObjectClassName() {
        XCTAssertEqual(WordsTableViewCell.className, "WordsTableViewCell")
        
    }
    
    func testIntFormattedTime() {
        XCTAssertEqual(30.formattedTime, "00:30")
    }
    
}
