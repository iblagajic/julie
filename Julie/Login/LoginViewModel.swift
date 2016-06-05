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
    
    let loggingIn: Observable<Bool>
    
    let bag = DisposeBag()
    
    init(navigationService: NavigationService) {
        let loginController = LoginController()
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()
        validatedUsername = usernameObservable.map(Validator.isValidEmail).shareReplay(1)
        validatedPassword = passwordObservable.map(Validator.isValidPassword).shareReplay(1)
        loginEnabled = Observable.combineLatest(validatedUsername, validatedPassword) { $0 && $1 }
        let usernameAndPassword = Observable.combineLatest(usernameObservable, passwordObservable) { ($0, $1) }
        let activityIndicator = ActivityIndicator()
        loggingIn = activityIndicator.asObservable()
        loginTap.withLatestFrom(usernameAndPassword)
            .flatMapLatest { (username, password) -> Observable<RHKSession?> in
                return loginController.login(username, password: password)
                    .catchErrorJustReturn(nil)
                    .trackActivity(activityIndicator)
            }.asDriver(onErrorJustReturn: nil)
            .driveNext { session in
                guard let token = session?.token.accessToken else {
                    print("Ej")
                    return
                }
                navigationService.pushPlayer(token, rhapsody: loginController.rhapsody)
            }.addDisposableTo(bag)
    }
    
}
