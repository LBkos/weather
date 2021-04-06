//
//  ListWeatherView.swift
//  Weather
//
//  Created by Константин Лопаткин on 02.04.2021.
//

import SwiftUI

struct ListWeatherView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
            ScrollView {
                ForEach(viewModel.data.indices, id: \.self) { i in
                    RowView(viewModel: viewModel, index: i)
                        .padding(-4)
                }
            }.background(
                Image("no")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
    }
}

struct ListWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ListWeatherView(viewModel: ViewModel())
    }
}
