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
        return NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardWillShow)
            .map { notification -> CGRect? in
                guard let userInfo = notification.userInfo,
                    let frameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
                        return nil
                }
                return frameValue.cgRectValue
            }.filterNil()
    }
    
    var rx_keyboardDidHide: Observable<CGRect> {
        return NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardDidHide)
            .map { _ in CGRect.zero }
    }
    
    var rx_keyboardWillChange: Observable<CGRect> {
        return Observable.of(rx_keyboardWillShow, rx_keyboardDidHide).merge()
    }
    
}
