//
//  MessageCell.swift
//  hashtalk
//
//  Created by Yuşa Sarısoy on 21.04.2021.
//

import UIKit

class MessageCell: UITableViewCell {

  @IBOutlet weak var viewMessageBubble: UIView!
  @IBOutlet weak var labelMessage: UILabel!
  @IBOutlet weak var imageViewMe: UIImageView!
  @IBOutlet weak var imageViewYou: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()

    viewMessageBubble.layer.cornerRadius = viewMessageBubble.frame.height / 4
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
