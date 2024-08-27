//
//  TodoModel_CoreData.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import CoreData
// MARK: - CoreData Model

@objc(TodoEntity)
public class TodoEntity: NSManagedObject {
    @NSManaged public var id: Int32
    @NSManaged public var todo: String?
    @NSManaged public var completed: Bool
    @NSManaged public var userId: Int32
    @NSManaged public var desc: String?
    @NSManaged public var created: Date?
}

extension TodoEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }
}
