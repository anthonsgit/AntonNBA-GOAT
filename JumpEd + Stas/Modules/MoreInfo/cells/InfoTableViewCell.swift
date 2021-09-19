//
//  InfoTableViewCell.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 04.09.2021.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var staticLabel: UILabel?
    @IBOutlet weak var valueLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
