//
//  ContentView.swift
//  Weather
//
//  Created by Константин Лопаткин on 19.03.2021.
//

import SwiftUI
import URLImage

struct WeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var commentVM = CommentViewModel()

    @Environment(\.managedObjectContext) var moc
    @State var weather: Weather?
    
    @FetchRequest(entity: City.entity(), sortDescriptors: [])
    private var city: FetchedResults<City>
    
    var body: some View {
        VStack {
            if let icon = weather?.current?.condition.icon {
                URLImage(url: URL(string: ("https:\((icon))"))!) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                Text(weather?.current?.condition.text ?? "no").font(.headline)
            }
            VStack {
                Text(weather?.location?.name ?? "--").font(.title)
                Text("\(Int((weather?.current?.temperatureC) ?? 0))º C").font(.largeTitle)
            }.padding()
            //Add comment button
            Button(action: {
                commentVM.commentToggle.toggle()
            }){
                HStack {
                    Image(systemName: "square.and.pencil")
                    Text("Add Comment")
                }
            }.sheet(isPresented: $commentVM.commentToggle, content: {
                CommentView(commentVM: commentVM, weather: weather)
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
                                    commentVM.editComment(item: comment)
                                    commentVM.commentToggle.toggle()
                                }.sheet(isPresented: $commentVM.commentToggle, content: {
                                    CommentView(commentVM: commentVM, weather: weather)
                                })
                            }
                        }.onDelete(perform: { offsets in
                            commentVM.deleteComment(offsets: offsets, from: item, moc: moc)
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
        WeatherView(weatherVM: WeatherViewModel())
    }
}
