//
//  NBAViewModel.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 01.09.2021.
//

import UIKit
import RealmSwift

class NBAViewModel: NSObject {

    let realm = try! Realm()
    
    /// Возвращает кол-во объектов PasswordObject
    ///
    /// - Returns: целое число, кол-во объектов
    public func numberItem() -> Int {
        return realm.objects(NBAObject.self).count
    }
    
    /// Добавление нового объекта PasswordObject
    ///
    /// - Parameters:
    ///   - title: Наименование записи о пароле
    ///   - username: имя пользователя
    ///   - website: сайт от куда пароль
    ///   - password: пароль для конкретного имени пользования
    public func addNewItem(name: String, lastName: String, team: String, city: String, conf: String, abbreviation: String) {
        
        let object: NBAObject = NBAObject()
        object.name = name
        object.lastName = lastName
        object.team = team
        object.teamCity = city
        object.teamConference = conf
        object.teamAbbreviation = abbreviation
        object.index = ((realm.objects(NBAObject.self).max(ofProperty: "index") as Int?) ?? -1) + 1
        
        try! realm.write {
            realm.add(object)
        }
    }
    
    /// Редактируем уже имеющийся объект PasswordObject
    ///
    /// - Parameters:
    ///   - index: индекс записи о пароле
    ///   - username: имя пользователя
    ///   - website: сайт от куда пароль
    ///   - password: пароль для конкретного имени пользования
    public func updateItem(index: Int, name: String, lastName: String, team: String, city: String, conf: String, abbreviation: String) {
        
        let oldobject = realm.objects(NBAObject.self).filter("index == %i", index).first
        
        let object: NBAObject = NBAObject()
        object.index = index
        object.name = name
        object.lastName = lastName
        object.team = team
        object.teamCity = city
        object.teamConference = conf
        object.teamAbbreviation = abbreviation
        
        try! realm.write {
            realm.add(object, update: .all)
        }
    }
    
    /// Получить объект PasswordObject по строке расположения в таблице(коллекции) отображения
    ///
    /// - Parameter indexRow: номер строки
    /// - Returns: объект PasswordObject
    public func item(indexRow: Int) -> NBAObject {
        
        let object: NBAObject? = realm.objects(NBAObject.self).sorted(byKeyPath: "index", ascending: true)[indexRow]
        return object!
    }
    
    /// Получить объект PasswordObject по индексу
    ///
    /// - Parameter index: индексный номер
    /// - Returns: объект PasswordObject
    public func item(index: Int) -> NBAObject {
        
        let object: NBAObject? = realm.objects(NBAObject.self).filter("index == %i", index).first
        return object!
    }
    
    /// Удаляет объект PasswordObject по его индексу
    ///
    /// - Parameter index: индекс объекта PasswordObject
    public func deleteItem(index: Int) {
        
        let object: NBAObject = item(index: index)
        
        try! realm.write {
            realm.delete(object)
        }
    }
    
    public func deleteAll(){
        try! realm.write({
            realm.delete(realm.objects(NBAObject.self))
        })
    }
}
 

