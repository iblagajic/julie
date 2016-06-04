//
//  LoginViewModel.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    let username = Variable("")
    let password = Variable("")
    let loginTap = PublishSubject<Void>()
    
    let validatedUsername: Observable<Bool>
    let validatedPassword: Observable<Bool>
    let loginEnabled: Observable<Bool>
    
    let loggedIn: Observable<Bool>
    let loggingIn: Observable<Bool>
    
    init() {
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()
        validatedUsername = usernameObservable.map(Validator.isValidEmail).shareReplay(1)
        validatedPassword = passwordObservable.map(Validator.isValidPassword).shareReplay(1)
        loginEnabled = Observable.combineLatest(validatedUsername, validatedPassword) { $0 && $1 }
        let usernameAndPassword = Observable.combineLatest(usernameObservable, passwordObservable) { ($0, $1) }
        let activityIndicator = ActivityIndicator()
        loggingIn = activityIndicator.asObservable()
        loggedIn = loginTap.debug().withLatestFrom(usernameAndPassword)
            .flatMapLatest { (username, password) -> Observable<Bool> in
                let loginController = LoginController()
                return loginController.login(username, password: password)
                    .catchErrorJustReturn(false)
                    .trackActivity(activityIndicator)
            }
    }
    
}
