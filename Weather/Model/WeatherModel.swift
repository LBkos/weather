//
//  Model.swift
//  Weather
//
//  Created by Константин Лопаткин on 19.03.2021.
//

import Foundation

struct Weather: Codable {
    
    var location: Location?
    var current: Current?
    
}
struct Location: Codable {
    var name: String
    var region: String
    var country: String

}
struct Current: Codable {
    var lastUpdate: String
    var temperatureC:  Float?
    var condition: Condition
    
    private enum CodingKeys : String, CodingKey {
            case lastUpdate = "last_updated", temperatureC = "temp_c", condition
        }
    

}
struct Condition: Codable {
    var text: String
    var icon: String
    var code: Int
    
    private enum CodingKeys: String, CodingKey {
        case text, icon, code
    }
}
