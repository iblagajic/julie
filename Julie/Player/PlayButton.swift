//
//  PlayButton.swift
//  Julie
//
//  Created by Ivan Blagajić on 24/07/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
    
    static let roundButtonTouchDownScale: CGFloat = 0.9
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(touchDown),
                  for: UIControlEvents.touchDown)
        addTarget(self, action: #selector(cancel),
                  for: [UIControlEvents.touchUpOutside, UIControlEvents.touchCancel, UIControlEvents.touchDragExit])
    }
    
    func touchDown() {
        animateChanges{ () -> Void in
            self.transform = CGAffineTransform(scaleX: PlayButton.roundButtonTouchDownScale, y: PlayButton.roundButtonTouchDownScale)
            self.imageView?.alpha = 0.0
            self.backgroundColor = .action()
        }
    }
    
    func cancel() {
        animateChanges{ () -> Void in
            self.setIdle()
        }
    }
    
    func animateChanges(_ changes:@escaping () -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0,
                                   usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 0,
                                   options: UIViewAnimationOptions.beginFromCurrentState,
                                   animations: { () -> Void in
                                    changes()
            }, completion: nil)
    }
    
    func setIdle() {
        self.transform = CGAffineTransform.identity
        self.imageView?.alpha = 1.0
        self.backgroundColor = .primary()
    }
}
