//
//  Presenter.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import Foundation

class TodoPresenter: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var showAddTodo = false
    @Published var showUpdateTodo = false
    @Published var updatingTodo: Todo
    
    private let interactor: TodoInteractor
    private let router: TodoRouter
    
    init(interactor: TodoInteractor, router: TodoRouter) {
        self.interactor = interactor
        self.router = router
        self.updatingTodo = Todo(id: 0, todo: "", completed: false, userId: 1)}
    
    func loadTodos() {
        interactor.fetchTodos { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todos):
                    self?.todos = todos
                case .failure(let error):
                    print("Error loading todos: \(error)")
                }
            }
        }
    }
    
    func addTodo(todo: String, _ description: String) {
        let newTodo = Todo(id: todos.count + 1, todo: todo, desc: description, completed: false, userId: 1)
        interactor.saveTodo(newTodo) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todo):
                    self?.todos.append(todo)
                case .failure(let error):
                    print("Error saving todo: \(error)")
                }
            }
        }
    }
    
    func updateTodo(_ todo: Todo) {
        var updatedTodo = todo
        if !showUpdateTodo {
            updatedTodo.completed.toggle()
        }
        interactor.updateTodo(updatedTodo) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedTodo):
                    if let index = self?.todos.firstIndex(where: { $0.id == updatedTodo.id }) {
                        self?.todos[index] = updatedTodo
                    }
                case .failure(let error):
                    print("Error updating todo: \(error)")
                }
            }
        }
    }
    
    func deleteTodo(at offsets: IndexSet) {
        offsets.forEach { index in
            let todo = todos[index]
            interactor.deleteTodo(todo) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.todos.remove(at: index)
                    case .failure(let error):
                        print("Error deleting todo: \(error)")
                    }
                }
            }
        }
    }
}
