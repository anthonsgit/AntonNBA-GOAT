//
//  Support.swift
//  antilocationvpn
//
//  Created by Stas on 23/05/2020.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit
 
let screenSize = UIScreen.main.bounds.size

typealias EmptyBlock = () -> Swift.Void
typealias SuccessFunc = ()->()
typealias FailedFunc = ()->()

var isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

enum LocaleKey: String {
    case Main = "Main"
    case Core = "Core"
}

extension UIViewController {
    
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView]) {
        
        if subviews.count > 0 {
            for subView in subviews {
                
                if let toRightArrow = subView as? UIImageView, toRightArrow.tag < 0, let _img = toRightArrow.image {
                    toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
                }
                
                loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews)
            }
        }
    }
}

extension TimeInterval{

    func stringFromTimeInterval() -> String {

        let time = NSInteger(self)
 
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)

    }
}

enum DeviceType {
    case iPhone
    case iPad
}

func isTypeDevice() -> DeviceType { 
    if UIDevice.current.userInterfaceIdiom == .phone {
        return .iPhone
    }else {
        return .iPad
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        
        layoutIfNeeded()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
