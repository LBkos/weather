//
//  WeatherApp.swift
//  Weather
//
//  Created by Константин Лопаткин on 06.04.2021.
//

import SwiftUI

@main
struct WeatherApp: App {
    @ObservedObject var weatherVM = WeatherViewModel()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
            ListWeatherView(weatherVM: weatherVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.dark)
            }.accentColor(Color(.cyan))
        }
    }
}
