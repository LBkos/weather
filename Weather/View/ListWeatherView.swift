//
//  ListWeatherView.swift
//  Weather
//
//  Created by Константин Лопаткин on 02.04.2021.
//

import SwiftUI

struct ListWeatherView: View {
    @ObservedObject var vm: ViewModel
    
    var body: some View {
            ScrollView {
                ForEach(vm.data.indices, id: \.self) { i in
                    RowView(viewModel: vm, index: i)
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
        ListWeatherView(vm: ViewModel())
    }
}
