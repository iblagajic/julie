//
//  LoginController.swift
//  Julie
//
//  Created by Ivan Blagajić on 03/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginController {
    
    let rhapsody: RHKRhapsody
    let session = URLSession.shared
    let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody) {
        self.rhapsody = rhapsody
    }
    
    func login(_ username: String, password: String) -> Observable<Bool> {
        let request = NSMutableURLRequest()
        request.url = URL(string: "https://api.rhapsody.com/oauth/token")
        request.httpMethod = "POST"
        let params = "username=\(username)&password=\(password)&grant_type=password"
        request.httpBody = params.data(using: String.Encoding.utf8)
        let auth = "\(rhapsody.consumerKey):\(rhapsody.consumerSecret)"
        guard let authData = auth.data(using: String.Encoding.utf8) else {
            return Observable.just(false)
        }
        let authEncoded = authData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        request.setValue("Basic \(authEncoded)", forHTTPHeaderField: "Authorization")
        return session.rx.json(request: request as URLRequest)
            .flatMap { [weak self] response -> Observable<Bool> in
                guard let `self` = self else { return Observable.just(false) }
                return self.handleLoginResponse(response as AnyObject)
        }
    }
    
    fileprivate func handleLoginResponse(_ loginResponse: AnyObject) -> Observable<Bool> {
        guard let accessToken = loginResponse["access_token"] as? String,
            let refreshToken = loginResponse["refresh_token"] as? String,
            let expirationInterval = loginResponse["expires_in"] as? TimeInterval else {
                return Observable.just(false)
        }
        let expirationDate = Date().addingTimeInterval(expirationInterval)
        let token = RHKOAuthToken(accessToken: accessToken, refreshToken: refreshToken, expirationDate: expirationDate)
        return openSession(token)
    }
    
    fileprivate func openSession(_ token: RHKOAuthToken?) -> Observable<Bool> {
        return Observable.create { [weak self] observer -> Disposable in
            self?.rhapsody.openSession(with: token) { session, error in
                if let _ = error {
                    observer.onNext(false)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
}
