//
//  DetailsTableViewCell.swift
//  Julie
//
//  Created by Ivan Blagajić on 06/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playingIndicator: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        playingIndicator.tintColor = .action()
        titleLabel?.font = .body()
        titleLabel?.textColor = .primary()
        timeLabel?.font = .microBold()
        timeLabel?.textColor = .secondary()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        playingIndicator.isHidden = !selected
    }

}
