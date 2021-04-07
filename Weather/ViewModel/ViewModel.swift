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

class ViewModel: ObservableObject {
    
    @Published var data = [Weather]()
    @Published var text = ""
    @Published var commentToggle = false
    @Published var updateComment: Comment?
    @Published var parameters = ["barnaul", "paris", "moscow", "London"]
    
    // apiKey = "88a1f4f26c7d49538cd95323211903"
    var baseURL =  "https://api.weatherapi.com/v1/"
    var params = ["q": "barnaul"]
    var headers = HTTPHeaders(["key": "595e87238d5a422080b114513211903"])
    var bag = Set<AnyCancellable>()
    //Weater functions
    func getData(param: [String:String]) -> AnyPublisher<Weather, Error> {
        return AF.request(baseURL+"current.json", method: .get, parameters: param, headers: headers).publishData()
            .map{ $0.data! }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    // get data for parameters
    func getWeather() {
        for p in parameters {
            params["q"] = p
            getData(param: params).sink(receiveCompletion: { (_) in
                 
             }, receiveValue: {[self] item in
                data.append(item)
             }).store(in: &bag)
        }
    }
    // Save Comments functions
    func saveComment(cityName: String, moc: NSManagedObjectContext){
            let comment = Comment(context: moc)
            comment.text = text
            comment.city = City(context: moc)
            comment.city?.name = cityName
            comment.city?.comment = NSSet(object: comment)
            
            try? moc.save()
            text = ""
    }
    // Edit Comments functions
    func editComment(item: Comment) {
        updateComment = item
        text = updateComment?.text ?? ""
    }
    // Update Comments functions
    func updateComments(moc: NSManagedObjectContext) {
        if updateComment != nil {
            updateComment?.text = text
            try? moc.save()
            updateComment = nil
            text = ""
        }
    }
    // Delete Comments functions
    func deleteItems(offsets: IndexSet, from city: City, moc: NSManagedObjectContext) {
            for offset in offsets.sorted().reversed() {
                let commentToDelete = city.commentArray[offset]
                city.removeFromComment(commentToDelete)
                moc.delete(commentToDelete)
            }
            if moc.hasChanges{ try? moc.save() }
        
    }
    
    init() {
        //Clear list background
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        getWeather()
    }
}
