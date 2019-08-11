//
//  QuizServiceProtocol.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 10/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

protocol QuizServiceProtocol: AnyObject {
func retrieveQuizWords(completion: @escaping (Result<Question, ServiceError>) -> Void)
}
