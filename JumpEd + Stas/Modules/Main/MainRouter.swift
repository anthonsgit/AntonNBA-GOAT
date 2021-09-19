//
//  MainRouter.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 01.09.2021.
//

import UIKit

//MARK: - protocol interface
protocol MainRouterInterface: AnyObject {
    func openInfo(data: [String])
}
//MARK: -

//MARK: - class
class MainRouter: NSObject, MainRouterInterface {
    private weak var controller: MainViewController?
    
    init(controller: MainViewController) {
        self.controller = controller
    }
}
//MARK: -

//MARK: - interface
extension MainRouter {
    
    func openInfo(data: [String]){
        let vc = MoreInfoViewController()
        vc.valueTexts = data
        controller?.present(vc, animated: true, completion: nil)
    }
    
}
//MARK: -
