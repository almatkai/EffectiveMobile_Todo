//
//  ContentView.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//

import SwiftUI
import CoreData
import Foundation


struct ContentView: View {
    @StateObject var presenter: TodoPresenter
    
    var body: some View {
        NavigationView {
            List {
                ForEach(presenter.todos.reversed()) { todo in
                    TodoRow(todo: todo, presenter: presenter)
                }
                .onDelete(perform: presenter.deleteTodo)
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { presenter.showAddTodo = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $presenter.showAddTodo) {
            AddTodoView(presenter: presenter)
        }
        .sheet(isPresented: $presenter.showUpdateTodo) {
            UpdateTodoView(presenter: presenter)
        }
        .onAppear {
            presenter.loadTodos()
        }
    }
}
