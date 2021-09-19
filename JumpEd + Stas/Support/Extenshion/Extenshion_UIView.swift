//
//  Extenshion_UIView.swift
//  wifiPointApp
//
//  Created by Stas on 01.07.2021.
//

import UIKit

//MARK: - прогрузка из ниба вьюхи
extension UIView {
    @discardableResult
    func fromNib<T>() -> T? where T: UIView {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll(to: self)
        return contentView
    }
    
    
    func layoutAttachAll(to viewConstraint: UIView) {
        self.topAnchor.constraint(equalTo: viewConstraint.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: viewConstraint.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: viewConstraint.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: viewConstraint.trailingAnchor, constant: 0).isActive = true
    }
    
}


extension UILabel {
    func fadeTransition(_ duration:CFTimeInterval, text: String) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push 
        self.text = text
        animation.duration = duration
        self.layer.add(animation, forKey: CATransitionType.push.rawValue)
        }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
