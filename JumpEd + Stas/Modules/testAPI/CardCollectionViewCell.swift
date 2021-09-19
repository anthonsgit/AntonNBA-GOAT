//
//  CardCollectionViewCell.swift
//  JumpEd + Stas
//
//  Created by Антон Воронов on 12.09.2021.
//
// Прикрепить к каждой карточке лого команды, при рандоме лого меняется в соответсвии с командой игрока
//Навести красоту в дизайне на твой взгляд

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
    }
    
    private func setupLabels(){
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25.4)
        teamLabel.font = UIFont.systemFont(ofSize: 24.4)
        positionLabel.font = UIFont.systemFont(ofSize: 24.4)
    }
    
    func setupData(name: String, team: String, pos: String){
        nameLabel.text = name
        teamLabel.text = team
        positionLabel.text = pos
    }
    
}
