//
//  ListWeatherView.swift
//  Weather
//
//  Created by Константин Лопаткин on 02.04.2021.
//

import SwiftUI

struct ListWeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
            ScrollView {
                ForEach(weatherVM.data.indices, id: \.self) { i in
                    RowView(weatherVM: weatherVM, index: i)
                        .padding(-4)
                }
            }.background(
                Image("no")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.8)
                    .ignoresSafeArea()
            )
    }
}

struct ListWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ListWeatherView(weatherVM: WeatherViewModel())
    }
}
