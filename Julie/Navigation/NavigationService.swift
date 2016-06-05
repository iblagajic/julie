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
    
    func pushPlayer(rhapsody:RHKRhapsody, animated: Bool = true) {
        let viewModel = PlayerViewModel(rhapsody: rhapsody, navigationService: self)
        let viewController = PlayerViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushNowPlaying(player: Player, animated: Bool = true) {
        let viewModel = NowPlayingViewModel(player: player)
        let viewController = NowPlayingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}
