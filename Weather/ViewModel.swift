//
//  ViewModel.swift
//  Weather
//
//  Created by Константин Лопаткин on 19.03.2021.
//

import Foundation
import Combine
import Alamofire
import CoreData
import SwiftUI


class ViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Published var listData: [String: Float] = [:]
    @Published var textPlus = ""
    @Published var data = [Weather]()
    @Published var weather: Weather?
    @Published var search: String = ""
    @Published var text = ""
    @Published var commentToggle = false


    @Published var lastUpdate: Int = 0
    @Published var imageUrl: URL?
    @Published var now = Date()
    
    @Published var parameters = ["barnaul", "paris", "moscow", "London"]
    private var apiKey = "88a1f4f26c7d49538cd95323211903"
    var baseURL =  "https://api.weatherapi.com/v1/"
    var params = ["q": "barnaul"]
    var headers = HTTPHeaders(["key": "595e87238d5a422080b114513211903"])
    var bag = Set<AnyCancellable>()
    var cancellable: AnyCancellable?
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
        .eraseToAnyPublisher()
    
    //functions
    func getData(param: [String:String]) -> AnyPublisher<Weather, Error> {
        return AF.request(baseURL+"current.json", method: .get, parameters: param, headers: headers).publishData()
            .map{ $0.data! }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func update() -> AnyPublisher<Int, Error> {
        return AF.request(baseURL+"current.json", method: .get, parameters: params, headers: headers).publishData()
            .map{ $0.data! }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .map{ $0.location?.localtime_epoch ?? 0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func addItem(cityName: String) {
        withAnimation {
            let comment = Comment(context: viewContext)
            comment.id = UUID()
            comment.text = text
            let city = City(context: viewContext)
            city.name = cityName
            city.addToComment(comment)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
//    func dataWeather() {
//       getData().sink(receiveCompletion: { (_) in
//
//        }, receiveValue: {[self] item in
//
//            weather = item
//            imageUrl = URL(string: ("https:\((weather?.current?.condition.icon)!)"))
//            lastUpdate = (weather?.location?.localtime_epoch)!
//            listData["Cloud"] = Float((weather?.current!.cloud)!)
//            listData["Visibility"] = weather?.current?.vis_km
//            listData["Wind"] = weather?.current?.wind_kph
//
//        }).store(in: &bag)
//    }
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        for p in parameters {
            params["q"] = p
            getData(param: params).sink(receiveCompletion: { (_) in
                 
             }, receiveValue: {[self] item in
                 
                 weather = item
                data.append(weather!)
                 imageUrl = URL(string: ("https:\((weather?.current?.condition.icon)!)"))
                 lastUpdate = (weather?.location?.localtime_epoch)!
                 listData["Cloud"] = Float((weather?.current!.cloud)!)
                 listData["Visibility"] = weather?.current?.vis_km
                 listData["Wind"] = weather?.current?.wind_kph
                 
             }).store(in: &bag)
//            Publishers.CombineLatest($now, $lastUpdate)
//                .sink { [self] date in
//                    self.update().sink(receiveCompletion: { (_) in
//
//                    }, receiveValue: {[self] item in
//                        if lastUpdate < item {
//                            lastUpdate = item
//                            dataWeather()
//                            print(lastUpdate)
//                        }
//                    }).store(in: &bag)
//                }.store(in: &bag)
        }
        
    }
}
