//
//  NetworkService.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import Foundation


protocol NetworkService {
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void)
}

// MARK: - Service Implementations

class NetworkServiceImpl: NetworkService {
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let todoResponse = try JSONDecoder().decode(TodoResponse.self, from: data)
                completion(.success(todoResponse.todos))
            } catch {
                print("Error decoding todos: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}



