//
//  AddTodoView.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import SwiftUI

struct AddTodoView: View {
    @ObservedObject var presenter: TodoPresenter
    @State private var todoText = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Todo", text: $todoText)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        presenter.addTodo(todo: todoText, description)
                        presenter.showAddTodo = false
                    }
                }
            }
        }
    }
}
