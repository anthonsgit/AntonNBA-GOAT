//
//  NBAObject.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 01.09.2021.
//

import Foundation
import RealmSwift

class NBAObject: Object {
    
    @objc dynamic var index = 0
    @objc dynamic var name = ""
    @objc dynamic var lastName = ""
    @objc dynamic var team = ""
    @objc dynamic var teamCity = ""
    @objc dynamic var teamAbbreviation = ""
    @objc dynamic var teamConference = ""
    
    override static func primaryKey() -> String? {
        return "index"
    }
}


struct NBAPlayer {
    var name: String
    var lastName: String
    var team: NBATeam
}

struct NBATeam {
    var fullName: String
    var city: String
    var abbreviation: String
    var conference: String
}
