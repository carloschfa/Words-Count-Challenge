//
//  Question.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 08/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    var question: String
    var words: [String]
    
    enum CodingKeys: String, CodingKey {
        case question = "question"
        case words = "answer"
    }
    
}
