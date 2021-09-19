//
//  Extenshion_UIButton.swift
//  scp
//
//  Created by Stas on 23.07.2021.
//

import Foundation
import UIKit

extension UIButton {
    func setSCPButton(){
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor("#298D69")
        self.setTitleColor(.white, for: .normal)
    }
}
