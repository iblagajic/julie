//
//  UITextFieldDelegateProxy.swift
//  Julie
//
//  Created by Ivan Blagajić on 14/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift
import RxCocoa

open class UITextFieldDelegateProxy: DelegateProxy, UITextFieldDelegate, DelegateProxyType {
    
    let rx_return = PublishSubject<Void>()
    
    open static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let textField: UITextField = object as! UITextField
        return textField.delegate
    }
    
    open static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let textField: UITextField = object as! UITextField
        textField.delegate = delegate as? UITextFieldDelegate
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        rx_return.onNext()
        return false
    }
    
}
