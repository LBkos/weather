//
//  WeatherApp.swift
//  Weather
//
//  Created by Константин Лопаткин on 06.04.2021.
//

import SwiftUI

@main
struct WeatherApp: App {
    @ObservedObject var viewModel = ViewModel()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
            ListWeatherView(vm: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.dark)
            }.accentColor(Color(.cyan))
        }
    }
}
