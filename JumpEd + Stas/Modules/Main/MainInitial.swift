//
//  MainInitial.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 01.09.2021.
//

import UIKit

class MainInitial: NSObject {

    @IBOutlet weak var controllerMain: MainViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configurate()
    }
    
    private func configurate() {
        
        let presenter = MainPresenter()
        let router = MainRouter(controller: controllerMain)
        
        presenter.view = controllerMain
        presenter.controller = controllerMain
        presenter.router = router
        controllerMain.presenter = presenter
        controllerMain.router = router
    }
}
