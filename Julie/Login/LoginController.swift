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
    
    let apiKey = "ODUzZTc4MTctNGY4Ni00MzdlLWEwMzEtMTBhZDZmZjg2M2Fj"
    let apiSecret = "YzMxNWVkNjQtMDU0NS00NDI0LWFlNGYtMDFhYjBkMWI3M2M2"
    let rhapsody: RHKRhapsody
    let session = NSURLSession.sharedSession()
    let bag = DisposeBag()
    
    init() {
        rhapsody = RHKRhapsody(consumerKey: apiKey, consumerSecret: apiSecret)
    }
    
    func login(username: String, password: String) -> Observable<Bool> {
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
        return session.rx_JSON(request).map { response in
            guard let response = response as? [String : AnyObject],
                token = response["refresh_token"] else {
                return false
            }
            return true
        }
    }
    
    
    
}
