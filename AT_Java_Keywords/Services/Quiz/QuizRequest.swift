//
//  QuizRequest.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 10/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

enum QuizRequest: Request {
    
    case get
    
    public var path: URL {
        switch self {
        case .get:
            return URL(string: "https://codechallenge.arctouch.com/quiz/java-keywords")!
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
    public var parameters: RequestParameters? {
        switch self {
        default:
            return nil
        }
    }
    
    public var headers: [String : Any]? {
        switch self {
        default:
            return [:]
        }
    }
    
}
