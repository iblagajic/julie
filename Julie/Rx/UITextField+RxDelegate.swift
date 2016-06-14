//
//  UITextField+RxDelegate.swift
//  Julie
//
//  Created by Ivan Blagajić on 14/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift
import RxCocoa

extension UITextField {
    
    public var rx_delegate: UITextFieldDelegateProxy {
        return UITextFieldDelegateProxy.proxyForObject(self)
    }
    
    public var rx_return: Observable<Void> {
        return rx_delegate.rx_return
    }
    
}
