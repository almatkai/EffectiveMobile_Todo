//
//  CoreDataStorageService.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import CoreData

class CoreDataStorageService: StorageService {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func fetchTodos() -> [Todo] {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let todoEntities = try container.viewContext.fetch(request)
            return todoEntities.map { Todo(id: Int($0.id), todo: $0.todo ?? "", desc: $0.desc ?? "", completed: $0.completed, userId: Int($0.userId), created: $0.created ?? Date()) }
        } catch {
            print("Error fetching todos: \(error)")
            return []
        }
    }
    
    func saveTodo(_ todo: Todo) throws {
        let todoEntity = TodoEntity(context: container.viewContext)
        todoEntity.id = Int32(todo.id)
        todoEntity.todo = todo.todo
        todoEntity.completed = todo.completed
        todoEntity.userId = Int32(todo.userId)
        todoEntity.desc = todo.desc
        todoEntity.created = todo.created
        try container.viewContext.save()
    }
    
    func updateTodo(_ todo: Todo) throws {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", todo.id)
        
        do {
            let todoEntities = try container.viewContext.fetch(request)
            guard let todoEntity = todoEntities.first else {
                throw NSError(domain: "Todo not found", code: 0, userInfo: nil)
            }
            
            todoEntity.todo = todo.todo
            todoEntity.desc = todo.desc
            todoEntity.completed = todo.completed
            
            try container.viewContext.save()
        } catch {
            throw error
        }
    }
    
    func deleteTodo(_ todo: Todo) throws {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", todo.id)
        
        do {
            let todoEntities = try container.viewContext.fetch(request)
            guard let todoEntity = todoEntities.first else {
                throw NSError(domain: "Todo not found", code: 0, userInfo: nil)
            }
            
            container.viewContext.delete(todoEntity)
            try container.viewContext.save()
        } catch {
            throw error
        }
    }
}

