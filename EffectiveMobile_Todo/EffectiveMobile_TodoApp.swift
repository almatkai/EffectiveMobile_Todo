//
//  EffectiveMobile_TodoApp.swift
//  EffectiveMobile_Todo
//
//  Created by Almat Kairatov on 27.08.2024.
//
import SwiftUI

@main
struct EffectiveMobile_TodoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            let networkService = NetworkServiceImpl()
            let storageService = CoreDataStorageService(container: persistenceController.container)
            let interactor = TodoInteractor(networkService: networkService, storageService: storageService)
            let router = TodoRouter()
            let presenter = TodoPresenter(interactor: interactor, router: router)
            
            ContentView(presenter: presenter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
