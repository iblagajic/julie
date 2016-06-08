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
    
    let session = NSURLSession.sharedSession()
    let bag = DisposeBag()
    
    func login(username: String, password: String) -> Observable<RHKRhapsody?> {
        let rhapsody = RHKRhapsody(consumerKey: apiKey, consumerSecret: apiSecret)
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
        return session.rx_JSON(request).flatMap{ response -> Observable<RHKRhapsody?> in
            return self.handleLoginResponse(rhapsody, loginResponse: response)
        }
    }
    
    private func handleLoginResponse(rhapsody: RHKRhapsody, loginResponse: AnyObject) -> Observable<RHKRhapsody?> {
        guard let accessToken = loginResponse["access_token"] as? String,
            refreshToken = loginResponse["refresh_token"] as? String,
            expirationInterval = loginResponse["expires_in"] as? NSTimeInterval else {
                return Observable.just(nil)
        }
        let expirationDate = NSDate().dateByAddingTimeInterval(expirationInterval)
        let token = RHKOAuthToken(accessToken: accessToken, refreshToken: refreshToken, expirationDate: expirationDate)
        return openSession(rhapsody, token: token)
    }
    
    private func openSession(rhapsody: RHKRhapsody, token: RHKOAuthToken) -> Observable<RHKRhapsody?> {
        return Observable.create { observer -> Disposable in
            rhapsody.openSessionWithToken(token) { session, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(rhapsody)
                }
            }
            return NopDisposable.instance
        }
    }
    
}
