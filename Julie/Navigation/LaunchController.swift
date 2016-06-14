//
//  LaunchController.swift
//  Julie
//
//  Created by Ivan Blagajić on 12/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

class LaunchController {
    
    let navigationService: NavigationService
    let rhapsody: RHKRhapsody
    
    init(navigationService: NavigationService, rhapsody: RHKRhapsody) {
        self.navigationService = navigationService
        self.rhapsody = rhapsody
    }
    
    func reopenOrPresentLogin() {
        let viewControllerType: FirstViewController = rhapsody.isSessionOpen ? .Player : .Login
        self.navigationService.pushFirstViewController(viewControllerType)
    }
    
}
