//
//  UIViewController+Keyboard.swift
//  Julie
//
//  Created by Ivan Blagajić on 08/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit
import RxSwift
import RxOptional

extension UIViewController {
    
    var rx_keyboardWillShow: Observable<CGRect> {
        return NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardWillShowNotification)
            .map { notification -> CGRect? in
                guard let userInfo = notification.userInfo,
                    let frameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
                        return nil
                }
                return frameValue.CGRectValue()
            }.filterNil()
    }
    
    var rx_keyboardDidHide: Observable<CGRect> {
        return NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardDidHideNotification)
            .map { _ in CGRectZero }
    }
    
    var rx_keyboardWillChange: Observable<CGRect> {
        return Observable.of(rx_keyboardWillShow, rx_keyboardDidHide).merge()
    }
    
}
