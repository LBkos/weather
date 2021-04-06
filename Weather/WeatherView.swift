//
//  ContentView.swift
//  Weather
//
//  Created by Константин Лопаткин on 19.03.2021.
//

import SwiftUI
import URLImage

struct WeatherView: View {
    @ObservedObject var vm: ViewModel
    @FetchRequest(entity: City.entity(), sortDescriptors: [])
    private var comment: FetchedResults<City>
    @State var weather: Weather?
    var body: some View {
        VStack {
            if weather?.current?.condition.icon != nil {
                URLImage(url: URL(string: ("https:\((weather?.current?.condition.icon)!)"))!) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                Text(weather?.current?.condition.text ?? "no").font(.headline)
            }
            VStack {
                Text(weather?.location?.name ?? "--").font(.title)
                Text("\(Int((weather?.current?.temp_c) ?? 0))º C").font(.largeTitle)
            }.padding()
            Button(action: {
                    vm.text = "Hello"
                    vm.addItem(cityName: weather?.location?.name ?? "on")}){
                Text("Comment")
            }.sheet(isPresented: $vm.commentToggle, content: {
                CommentsView(vm: vm)
            })
            Spacer()
            List {
                ForEach(comment, id: \.self) { item in
                    ForEach(item.commentArray) {com in
                        VStack(alignment: .leading) {
                            Text("\(com.text ?? "no")")
                        }
                    }
                    
                }.listRowBackground(Color.clear)
            }.listStyle(InsetListStyle())
        }
        .background(
            Image(weather?.current?.condition.text ?? "cloud")
                .resizable()
                .scaledToFill()
                .opacity(0.7)
                .background(Color.black)
                .ignoresSafeArea(.all)
        )
        .onReceive(vm.timer) { self.vm.now = $0 }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(vm: ViewModel())
    }
}
