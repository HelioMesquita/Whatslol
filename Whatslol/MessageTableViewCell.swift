//
//  MessageTableViewCell.swift
//  fastLearning
//
//  Created by Luis Gustavo Fermino Moraes on 06/10/22.
//


import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var viewBallon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBallon.backgroundColor = .systemBackground
        viewBallon.clipsToBounds = true
        viewBallon.layer.cornerRadius = 12
        
        self.viewBallon.layer.borderWidth = 10
        self.viewBallon.layer.cornerRadius = 12
        self.viewBallon.layer.borderColor = UIColor.clear.cgColor
        self.viewBallon.layer.masksToBounds = true
        
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 12)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        
    }
    
}

class LeftMessageTableViewCell: MessageTableViewCell {
    }

class RightMessageTableViewCell: MessageTableViewCell {
    }
