//
//  ToDoModel.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import Foundation

struct TodoResponse: Codable {
    let todos: [Todo]
}

struct Todo: Codable, Identifiable {
    let id: Int
    var todo: String = ""
    var desc: String = ""
    var completed: Bool
    let userId: Int
    var created: Date = Date()
}


