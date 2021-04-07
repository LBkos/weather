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

//    "current": {
//        "last_updated_epoch": 1616147112,
//        "last_updated": "2021-03-19 16:45",
//        "temp_c": -1.0,
//        "temp_f": 30.2,
//        "is_day": 1,
//        "condition": {
//            "text": "Sunny",
//            "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
//            "code": 1000
//        },
//        "wind_mph": 2.5,
//        "wind_kph": 4.0,
//        "wind_degree": 360,
//        "wind_dir": "N",
//        "pressure_mb": 1035.0,
//        "pressure_in": 31.0,
//        "precip_mm": 0.0,
//        "precip_in": 0.0,
//        "humidity": 50,
//        "cloud": 0,
//        "feelslike_c": -4.2,
//        "feelslike_f": 24.4,
//        "vis_km": 10.0,
//        "vis_miles": 6.0,
//        "uv": 2.0,
//        "gust_mph": 6.9,
//        "gust_kph": 11.2
//    }
//}
