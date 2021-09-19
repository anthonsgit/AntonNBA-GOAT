//
//  Extenshion_UISpringTimingParameters.swift
//  refashion
//
//  Created by Stas on 04.02.2021.
//  Copyright © 2021 Stas. All rights reserved.
//

import UIKit

extension UISpringTimingParameters {
    convenience init(damping: CGFloat, speed: CGFloat, initialVelocity: CGVector = .zero) {
        let stiffness = pow(2.0 * .pi / speed, 2)
        let damp = 4.0 * .pi * damping / speed
        self.init(mass: 1, stiffness: stiffness, damping: damp, initialVelocity: initialVelocity)
    }
}
