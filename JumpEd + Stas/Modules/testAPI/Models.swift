//
//  Models.swift
//  JumpEd + Stas
//
//  Created by Антон Воронов on 05.09.2021.
//

import UIKit
struct ObjDataNBA: Decodable {
    let data: [PlayerNBA]
}
struct PlayerNBA: Decodable {
    let firstName: String
    let lastName: String
    let playerPosition: String
    let playerTeam: Teams
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case playerPosition = "position"
        case playerTeam = "team"
    }
 
}
struct Teams: Decodable {
    let teamId: Int
    let fullName: String
    let teamCity: String
    enum CodingKeys: String, CodingKey {
        case teamId = "id"
        case fullName = "full_name"
        case teamCity = "city"
    }
}

