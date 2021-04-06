//
//  WeatherApp.swift
//  Weather
//
//  Created by Константин Лопаткин on 06.04.2021.
//

import SwiftUI

@main
struct WeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
