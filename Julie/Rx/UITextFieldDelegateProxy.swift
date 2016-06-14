//
//  UITextFieldDelegateProxy.swift
//  Julie
//
//  Created by Ivan Blagajić on 14/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift
import RxCocoa

public class UITextFieldDelegateProxy: DelegateProxy, UITextFieldDelegate, DelegateProxyType {
    
    let rx_return = PublishSubject<Void>()
    
    public static func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let textField: UITextField = object as! UITextField
        return textField.delegate
    }
    
    public static func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let textField: UITextField = object as! UITextField
        textField.delegate = delegate as? UITextFieldDelegate
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        rx_return.onNext()
        return false
    }
    
}
