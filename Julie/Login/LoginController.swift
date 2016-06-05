//
//  LoginController.swift
//  Julie
//
//  Created by Ivan Blagajić on 03/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift
import RxCocoa

enum LoginError: ErrorType {
    case InvalidToken
}

class LoginController {
    
    let apiKey = "ODUzZTc4MTctNGY4Ni00MzdlLWEwMzEtMTBhZDZmZjg2M2Fj"
    let apiSecret = "YzMxNWVkNjQtMDU0NS00NDI0LWFlNGYtMDFhYjBkMWI3M2M2"
    let rhapsody: RHKRhapsody
    let session = NSURLSession.sharedSession()
    let bag = DisposeBag()
    
    init() {
        rhapsody = RHKRhapsody(consumerKey: apiKey, consumerSecret: apiSecret)
    }
    
    func login(username: String, password: String) -> Observable<RHKSession?> {
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: "https://api.rhapsody.com/oauth/token")
        request.HTTPMethod = "POST"
        let params = "username=\(username)&password=\(password)&grant_type=password"
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        let auth = "\(apiKey):\(apiSecret)"
        guard let authData = auth.dataUsingEncoding(NSUTF8StringEncoding) else {
            return Observable.empty()
        }
        let authEncoded = authData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        request.setValue("Basic \(authEncoded)", forHTTPHeaderField: "Authorization")
        return session.rx_JSON(request).flatMap(openSession)
    }
    
    private func openSession(loginResponse: AnyObject) -> Observable<RHKSession?> {
        return Observable.create { observer -> Disposable in
            guard let accessToken = loginResponse["access_token"] as? String,
                refreshToken = loginResponse["refresh_token"] as? String,
                expirationInterval = loginResponse["expires_in"] as? NSTimeInterval else {
                    observer.onError(LoginError.InvalidToken)
                    return NopDisposable.instance
            }
            let expirationDate = NSDate().dateByAddingTimeInterval(expirationInterval)
            let token = RHKOAuthToken(accessToken: accessToken, refreshToken: refreshToken, expirationDate: expirationDate)
            self.rhapsody.openSessionWithToken(token) { session, error in
                if (session.isOpen) {
                    observer.onNext(session)
                } else {
                    observer.onError(LoginError.InvalidToken)
                }
            }
            return NopDisposable.instance
        }
    }
    
}
