//
//  ServiceError.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 10/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
    case raw(NSError?)
    
    case empty
    case invalid(String?)
    case unknown
    case blocked(String?)
    case notFound(String?)
    case parseError
    case unprocessable
    case unauthorized(String?)
    case unavailable(String?)
}

extension ServiceError {
    public var message: String {
        switch self {
        case .raw(let error):
            guard let error = error else {
                return localizedDescription
            }
            
            return error.localizedDescription
        case .unauthorized(let description),
             .blocked(let description),
             .invalid(let description),
             .notFound(let description):
            guard let description = description else {
                return localizedDescription
            }
            
            return description
        default:
            return localizedDescription
        }
    }
}
