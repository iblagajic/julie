//
//  Dependencies.swift
//  Julie
//
//  Created by Ivan Blagajić on 12/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

class Dependencies {
    
    let apiKey = "NzUyYTBmYjgtZTZlYS00ZWVmLTk4ZmMtYjg2YzhiNzI2NDU0"
    let apiSecret = "NGJiMTg2NzAtN2E4Yy00NWJjLThkMjItNzFiODc5ZjJjZGI4"
    
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
