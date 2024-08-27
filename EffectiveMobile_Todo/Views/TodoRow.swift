//
//  TodoRow.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import SwiftUI

struct TodoRow: View {
    let todo: Todo
    @ObservedObject var presenter: TodoPresenter
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    Text(todo.todo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if !todo.desc.isEmpty {
                        Text(todo.desc)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Spacer()
                Text(todo.created.formatted())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .background(Color(.systemBackground))
            .onTapGesture {
                presenter.showUpdateTodo = true
                presenter.updatingTodo = todo
            }
            Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    presenter.updateTodo(todo)
                }
        }
    }
}
