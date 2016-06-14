//
//  Dependencies.swift
//  Julie
//
//  Created by Ivan Blagajić on 12/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

class Dependencies {
    
    let apiKey = "ODUzZTc4MTctNGY4Ni00MzdlLWEwMzEtMTBhZDZmZjg2M2Fj"
    let apiSecret = "YzMxNWVkNjQtMDU0NS00NDI0LWFlNGYtMDFhYjBkMWI3M2M2"
    
    let rhapsody: RHKRhapsody
    let navigationService: NavigationService
    let launchController: LaunchController
    let loginController: LoginController
    
    init() {
        self.rhapsody = RHKRhapsody(consumerKey: apiKey, consumerSecret: apiSecret)
        self.navigationService = NavigationService()
        self.launchController = LaunchController(navigationService: navigationService, rhapsody: rhapsody)
        self.loginController = LoginController(rhapsody: rhapsody)
        self.navigationService.$ = self
    }
    
}
