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
    
    private static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }
    
    private static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size)!
    }
    
    static func input() -> UIFont {
        return standard(16.0)
    }
    
    static func h1() -> UIFont {
        return medium(18.0)
    }
    
    static func h2() -> UIFont {
        return medium(16.0)
    }
    
    static func microBold() -> UIFont {
        return bold(14.0)
    }
    
    static func bigRegular() -> UIFont {
        return standard(20.0)
    }
    
}
