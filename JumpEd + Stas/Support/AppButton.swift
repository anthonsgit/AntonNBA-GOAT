//
//  AppButton.swift
//  scp
//
//  Created by Stas on 23.07.2021.
//

import UIKit

class AppButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initView()
    }
}

private extension AppButton {
    func initView() {
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor("#298D69")
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
}
