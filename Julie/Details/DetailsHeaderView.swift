//
//  DetailsHeaderView.swift
//  Julie
//
//  Created by Ivan Blagajić on 19/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class DetailsHeaderView: UIView {

    let imageView = UIImageView()
    let overlay = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(overlay)
        
        overlay.autoPinEdgesToSuperviewEdges()
        imageView.autoPinEdgesToSuperviewEdges()
        
        imageView.contentMode = .scaleAspectFill
        overlay.backgroundColor = .white
        overlay.alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
