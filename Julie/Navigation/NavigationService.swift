//
//  NavigationService.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class NavigationService {
    
    private let navigationController = UINavigationController()
    
    func pushFirstViewController(inWindow window: UIWindow) {
        navigationController.navigationBarHidden = true
        pushLogin()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func pushLogin(animated: Bool = true) {
        let viewModel = LoginViewModel(navigationService: self)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushPlayer(token: String, rhapsody:RHKRhapsody, animated: Bool = true) {
        let dataProvider = DataProvider(token: token)
        let playerViewModel = PlayerViewModel(rhapsody: rhapsody, dataProvider: dataProvider)
        let viewController = PlayerViewController(playerViewModel: playerViewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}
