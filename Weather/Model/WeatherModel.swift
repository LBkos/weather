//
//  Model.swift
//  Weather
//
//  Created by Константин Лопаткин on 19.03.2021.
//

import Foundation


struct Weather: Codable {
    
    var location: location?
    var current: current?
    
}
struct location: Codable {
    var name: String
    var region: String
    var country: String
    var lat:  Float?
    var lon:  Float?
    var localtime_epoch: Int?
    var localtime: String
    
    
}
struct current: Codable {
    var last_updated_epoch: Int?
    var last_updated: String
    var temp_c:  Float?
    var temp_f:  Float?
    var lat:  Float?
    var lon:  Float?
    var is_day: Int
    var condition: condition
    var wind_kph: Float?
    var cloud: Int
    var vis_km: Float

}
struct condition: Codable {
    var text: String
    var icon: String
    var code: Int
}
