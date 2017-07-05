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
    let session = NSURLSession.sharedSession()
    let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody) {
        self.rhapsody = rhapsody
    }
    
    func login(_ username: String, password: String) -> Observable<Bool> {
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: "https://api.rhapsody.com/oauth/token")
        request.HTTPMethod = "POST"
        let params = "username=\(username)&password=\(password)&grant_type=password"
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        let auth = "\(rhapsody.consumerKey):\(rhapsody.consumerSecret)"
        guard let authData = auth.dataUsingEncoding(NSUTF8StringEncoding) else {
            return Observable.just(false)
        }
        let authEncoded = authData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        request.setValue("Basic \(authEncoded)", forHTTPHeaderField: "Authorization")
        return session.rx_JSON(request)
            .flatMap(handleLoginResponse)
    }
    
    fileprivate func handleLoginResponse(_ loginResponse: AnyObject) -> Observable<Bool> {
        guard let accessToken = loginResponse["access_token"] as? String,
            let refreshToken = loginResponse["refresh_token"] as? String,
            let expirationInterval = loginResponse["expires_in"] as? NSTimeInterval else {
                return Observable.just(false)
        }
        let expirationDate = NSDate().dateByAddingTimeInterval(expirationInterval)
        let token = RHKOAuthToken(accessToken: accessToken, refreshToken: refreshToken, expirationDate: expirationDate)
        return openSession(token)
    }
    
    fileprivate func openSession(_ token: RHKOAuthToken) -> Observable<Bool> {
        return Observable.create { [weak self] observer -> Disposable in
            self?.rhapsody.openSessionWithToken(token) { session, error in
                if let _ = error {
                    observer.onNext(false)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            }
            return NopDisposable.instance
        }
    }
    
}
