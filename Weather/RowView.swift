//
//  RowView.swift
//  Weather
//
//  Created by Константин Лопаткин on 03.04.2021.
//

import SwiftUI

struct RowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: ViewModel
    @State var index: Int
    var body: some View {
        
        NavigationLink(destination: WeatherView(vm: viewModel, weather: viewModel.data[index]).environment(\.managedObjectContext, viewContext)) {
            ZStack {
                Rectangle()
                    .stroke(lineWidth: 2).foregroundColor(.clear)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 110)
                //City name and temperature
                HStack {
                    Text(viewModel.data[index].location?.name ?? "").font(.title)
                    Spacer()
                    Text("\(Int(viewModel.data[index].current?.temp_c ?? 0))º")
                        .font(.title)
                        .bold()
                }
                .padding(.horizontal, 30)
                .foregroundColor(.white)
                
            }.background(
                Image(viewModel.data[index].current?.condition.text ?? "cloud")
                    .resizable()
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 110)
                    .scaledToFill()
                    .opacity(0.8)
                    .background(Color.black)
            )
        }
        .navigationTitle("Weather")
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(viewModel: ViewModel(), index: 0)
    }
}
