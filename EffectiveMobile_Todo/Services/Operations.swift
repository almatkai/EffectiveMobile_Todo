//
//  Operations.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import Foundation

protocol StorageService {
    func fetchTodos() -> [Todo]
    func saveTodo(_ todo: Todo) throws
    func updateTodo(_ todo: Todo) throws
    func deleteTodo(_ todo: Todo) throws
}

// MARK: - Operations

class FetchTodosOperation: Operation {
    private let networkService: NetworkService
    private let storageService: StorageService
    private(set) var result: Result<[Todo], Error>?
    private let completion: (Result<[Todo], Error>) -> Void
    
    init(networkService: NetworkService, storageService: StorageService, completion: @escaping (Result<[Todo], Error>) -> Void) {
        self.networkService = networkService
        self.storageService = storageService
        self.completion = completion
    }
    
    override func main() {
        let storedTodos = storageService.fetchTodos()
        if !storedTodos.isEmpty {
            print("Fetched todos from storage")
            result = .success(storedTodos)
            completion(.success(storedTodos))
        } else {
            networkService.fetchTodos { result in
                print("Fetched todos from network")
                self.result = result
                if case .success(let todos) = result {
                    todos.forEach { todo in
                        print(todo)
                        try? self.storageService.saveTodo(todo)
                    }
                }
                self.completion(result)
            }
        }
    }
}

class SaveTodoOperation: Operation {
    private let todo: Todo
    private let storageService: StorageService
    private(set) var result: Result<Todo, Error>?
    
    init(todo: Todo, storageService: StorageService) {
        self.todo = todo
        self.storageService = storageService
    }
    
    override func main() {
        do {
            try storageService.saveTodo(todo)
            result = .success(todo)
        } catch {
            result = .failure(error)
        }
    }
}

class UpdateTodoOperation: Operation {
    private let todo: Todo
    private let storageService: StorageService
    private(set) var result: Result<Todo, Error>?
    
    init(todo: Todo, storageService: StorageService) {
        self.todo = todo
        self.storageService = storageService
    }
    
    override func main() {
        do {
            try storageService.updateTodo(todo)
            result = .success(todo)
        } catch {
            result = .failure(error)
        }
    }
}

class DeleteTodoOperation: Operation {
    private let todo: Todo
    private let storageService: StorageService
    private(set) var result: Result<Void, Error>?
    
    init(todo: Todo, storageService: StorageService) {
        self.todo = todo
        self.storageService = storageService
    }
    
    override func main() {
        do {
            try storageService.deleteTodo(todo)
            result = .success(())
        } catch {
            result = .failure(error)
        }
    }
}

