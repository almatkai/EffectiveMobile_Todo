//
//  UpdateTodo.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import SwiftUI

struct UpdateTodoView: View {
    @ObservedObject var presenter: TodoPresenter
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Todo", text: $presenter.updatingTodo.todo)
                TextField("Description", text: $presenter.updatingTodo.desc)
                HStack {
                    Spacer()
                    Image(systemName: presenter.updatingTodo.completed ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            presenter.updatingTodo.completed.toggle()
                        }
                }
            }
            .navigationTitle("Update Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        presenter.updateTodo(presenter.updatingTodo)
                        presenter.showUpdateTodo = false
                    }
                }
            }
        }
    }
}
