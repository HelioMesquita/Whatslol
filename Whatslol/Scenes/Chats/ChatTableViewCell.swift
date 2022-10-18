//
//  ChatTableViewCell.swift
//  fastLearning
//
//  Created by Luis Gustavo Fermino Moraes on 28/09/22.
//

import Kingfisher
import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bulletView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 25
        profileImage.clipsToBounds = true
        bulletView.layer.cornerRadius = 12
        bulletView.clipsToBounds = true
    }

    func setValues(chat: ChatResponse){
        titleLabel.text = chat.name
        subtitleLabel.text = chat.lastMessage
        dateLabel.text = chat.lastMessageDate
        bulletView.isHidden = chat.hasVisualized
        profileImage.kf.setImage(with: chat.profileImage)
    }

}
