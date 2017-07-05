//
//  UIFont+Julie.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

extension UIFont {
    
    fileprivate static func standard(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir Next", size: size)!
    }
    
    fileprivate static func medium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }
    
    fileprivate static func bold(_ size: CGFloat) -> UIFont {
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
    
    static func body() -> UIFont {
        return standard(14.0)
    }
    
}
