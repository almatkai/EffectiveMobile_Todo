//
//  Interactor.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import Foundation

class TodoInteractor {
    
    private let networkService: NetworkService
    private let storageService: StorageService
    
    init(networkService: NetworkService, storageService: StorageService) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        let operation = FetchTodosOperation(networkService: networkService, storageService: storageService) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        OperationQueue().addOperation(operation)
    }
    
    func saveTodo(_ todo: Todo, completion: @escaping (Result<Todo, Error>) -> Void) {
        let operation = SaveTodoOperation(todo: todo, storageService: storageService)
        operation.completionBlock = {
            guard let result = operation.result else {
                print("Error saving todos")
                return
            }
            completion(result)
        }
        OperationQueue().addOperation(operation)
    }
    
    func updateTodo(_ todo: Todo, completion: @escaping (Result<Todo, Error>) -> Void) {
        let operation = UpdateTodoOperation(todo: todo, storageService: storageService)
        operation.completionBlock = {
            guard let result = operation.result else {
                print("Error updating todos")
                return
            }
            completion(result)
        }
        OperationQueue().addOperation(operation)
    }
    
    func deleteTodo(_ todo: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = DeleteTodoOperation(todo: todo, storageService: storageService)
        operation.completionBlock = {
            completion(operation.result!)
        }
        OperationQueue().addOperation(operation)
    }
}
