//
//  JZNameCardMediaItemView.swift
//  jianzhi
//
//  Created by daniel on 16/2/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZNameCardMediaItemView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func updateData(data: JZMessage) {
        if let nameCard = data.nameCard {
            nameLabel.text = nameCard.nickName
            descriptionLabel.text = data.text
        }
    }

}
