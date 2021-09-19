//
//  MainProtocol.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 01.09.2021.
//

import UIKit

protocol MainPresenterInputDelegate {
    
    /// предпоказ контроллера
    func willShowController()
    
    //предскрытие контролера
    func willHideController()
    
    //Количество объектов в массиве игроков (не зависит от соста сети)
    func countOfPlayers() -> Int
    
    //Передаем parsed массив
    func getParsedPlayers() -> [NBAPlayer]
    
    // Тот самый рандом :)
    func generateRndPageForPlayersList()
    
    //Готовит и открывает мор инфо экран
    func moreInfoAction(indexPath: Int)
}

protocol MainPresenterOutputDelegate: AnyObject {
    func setupCollection()
}
