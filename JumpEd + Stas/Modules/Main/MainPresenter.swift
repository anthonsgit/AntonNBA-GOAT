//
//  MainPresenter.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 01.09.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainPresenter: NSObject, MainPresenterInputDelegate {

    weak var view: MainPresenterOutputDelegate?
    weak var controller: MainViewController?
    weak var router: MainRouterInterface?
    
    var nbaPlayers = [NBAPlayer]()
    
    var nbaBase = NBAViewModel()
    var json: JSON?
    var url = "https://www.balldontlie.io/api/v1/players?page=150"{
        didSet{
            self.getPlayers()
        }
    }
    var isLoading = true{
        didSet{
            if !isLoading{
                self.parseObjects()
                self.saveToRealm()
                self.view?.setupCollection()
            }
        }
    }
    var badLogin = false{
        didSet{
            self.loadPlayersFromLastLogin()
            self.view?.setupCollection()
            self.controller?.isOfflineMode = true
        }
    }
    //MARK: - основа

    func willShowController() {
        getPlayers()
    }
    
    func willHideController() {
        
    }
    
    
    func getPlayers(){
        isLoading = true
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                self.json = JSON(value)
                self.json = self.json?["data"]
                self.parseObjects()
                self.isLoading = false
            case .failure(let error):
                print(error)
                self.badLogin = true
            }
        }
    }
    
    func parseObjects(){
        nbaPlayers.removeAll()
       // let path: [JSONSubscriptType] = [1, "data", 2,"first_name"]
        let parseData = self.json?.arrayValue.map({
            let name = $0["first_name"].stringValue
            let secondName = $0["last_name"].stringValue
            
            let teamName = $0["team"]["full_name"].stringValue
            let teamCity = $0["team"]["city"].stringValue
            let teamAbbreviation = $0["team"]["abbreviation"].stringValue
            let teamConference = $0["team"]["conference"].stringValue
            
            nbaPlayers.append(NBAPlayer(name: name,
                                        lastName: secondName,
                                        team: NBATeam(fullName: teamName,
                                                      city: teamCity,
                                                      abbreviation: teamAbbreviation,
                                                      conference: teamConference)))
        })
        saveToRealm()
    }
    
    func saveToRealm(){
        nbaBase.deleteAll()
        nbaPlayers.forEach { player in
            nbaBase.addNewItem(name: player.name, lastName: player.lastName,
                               team: player.team.fullName,
                               city: player.team.city, conf: player.team.conference,
                               abbreviation: player.team.abbreviation)
        }
    }
    
    func loadPlayersFromLastLogin(){
        for i in 0...nbaBase.numberItem()-1{
            let player = nbaBase.item(index: i)
            nbaPlayers.append(NBAPlayer(name: player.name, lastName: player.lastName,
                                        team: NBATeam(fullName: player.team,
                                                      city: player.teamCity,
                                                      abbreviation: player.teamAbbreviation,
                                                      conference: player.teamConference)))
        }
    }
    
    func generateRndPageForPlayersList(){
        nbaPlayers.removeAll()
        let rndPage = Int.random(in: 1...150)
        url = "https://www.balldontlie.io/api/v1/players?page=\(rndPage)"
    }
    
    func countOfPlayers() -> Int {
       return nbaPlayers.count
    }
    
    func getParsedPlayers() -> [NBAPlayer]{
        return nbaPlayers
    }
    
    func moreInfoAction(indexPath: Int){
        var dataForTranfer = [String]()
        let player = nbaPlayers[indexPath]
        
        dataForTranfer.append("\(player.name) \(player.lastName)")
        dataForTranfer.append("\(player.team.fullName)")
        dataForTranfer.append("\(player.team.city)")
        dataForTranfer.append("\(player.team.conference)")

        router?.openInfo(data: dataForTranfer)
    }
    
}
