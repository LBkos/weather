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
    @Environment(\.managedObjectContext) var moc
    @State var weather: Weather?
    
    @FetchRequest(entity: City.entity(), sortDescriptors: [])
    private var city: FetchedResults<City>
    
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
            //Add comment button
            Button(action: {
                vm.commentToggle.toggle()
            }){
                HStack {
                    Image(systemName: "square.and.pencil")
                    Text("Add Comment")
                }
            }.sheet(isPresented: $vm.commentToggle, content: {
                CommentView(vm: vm, weather: weather)
            })
            //list comments
            List {
                ForEach(city, id: \.self) { item in
                    if item.name == weather?.location?.name {
                        ForEach(item.commentArray, id: \.id) { comment in
                            HStack {
                                Text(comment.text ?? "")
                                    .lineLimit(4)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Image(systemName: "pencil").onTapGesture {
                                    vm.editComment(item: comment)
                                    vm.commentToggle.toggle()
                                }.sheet(isPresented: $vm.commentToggle, content: {
                                    CommentView(vm: vm, weather: weather)
                                })
                            }
                        }.onDelete(perform: { offsets in
                            vm.deleteItems(offsets: offsets, from: item, moc: moc)
                        })
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
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(vm: ViewModel())
    }
}
