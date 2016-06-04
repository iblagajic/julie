//
//  UIFont+Julie.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

extension UIFont {
    
    private static func standard(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir Next", size: size)!
    }
    
    private static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }
    
    static func input() -> UIFont {
        return standard(15.0)
    }
    
    static func h1() -> UIFont {
        return bold(19.0)
    }
    
}
