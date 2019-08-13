//
//  Result.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 10/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

public enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}
