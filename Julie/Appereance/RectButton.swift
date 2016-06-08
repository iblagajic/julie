//
//  RectButton.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class RectButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .action()
        tintColor = .standardBackground()
        titleLabel?.font = .h1()
    }

}
