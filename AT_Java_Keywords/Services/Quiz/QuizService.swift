//
//  QuizService.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 10/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

class QuizService: QuizServiceProtocol {
    
    // MARK: - Properties
    
    // MARK: - Initializers
    
    init() { }

}

extension QuizService {
    
    func retrieveQuizWords(completion: @escaping (Result<Question, ServiceError>) -> Void) {
        let request: QuizRequest = .get
        
        let task = URLSession.shared.dataTask(with: request.path) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.notFound(error?.localizedDescription)))
                return
            }
            
            guard response != nil else {
                completion(.failure(.empty))
                return
            }
            
            guard let data = data else {
                completion(.failure(.empty))
                return
            }
            
            do {
                
                let question = try JSONDecoder().decode(Question.self, from: data)
                
                #warning("A Delay was added to see the loading activity indicator, this should be removed after this test.")
                //DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    completion(.success(question))
                //}
                
            } catch let error {
                completion(.failure(.invalid(error.localizedDescription)))
            }
            
        }
        task.resume()
        
        
    }
    
}
