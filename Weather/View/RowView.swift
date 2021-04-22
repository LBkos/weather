//
//  RowView.swift
//  Weather
//
//  Created by Константин Лопаткин on 03.04.2021.
//

import SwiftUI

struct RowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var weatherVM: WeatherViewModel
    @State var index: Int
    var body: some View {
        
        NavigationLink(destination: WeatherView(weatherVM: weatherVM, weather: weatherVM.data[index]).environment(\.managedObjectContext, viewContext)) {
            ZStack {
                Rectangle()
                    .stroke(lineWidth: 1).foregroundColor(.clear)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 110)
                //City name and temperature
                HStack {
                    Text(weatherVM.data[index].location?.name ?? "").font(.title)
                    Spacer()
                    Text("\(Int(weatherVM.data[index].current?.temperatureC ?? 0))º")
                        .font(.title)
                        .bold()
                }
                .padding(.horizontal, 30)
                .foregroundColor(.white)
                
            }.background(
                Image(weatherVM.data[index].current?.condition.text ?? "cloud")
                    .resizable()
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 110)
                    .scaledToFit()
                    .opacity(0.8)
                    .background(Color.black)
            )
        }
        .navigationTitle("Weather")
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(weatherVM: WeatherViewModel(), index: 0)
    }
}
