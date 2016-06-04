//
//  TextField.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont.input()
        borderStyle = .None
        textColor = UIColor.primaryColor()
    }

}
