//
//  NavigationService.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

enum FirstViewController {
    case login
    case player
}

class NavigationService {
    
    fileprivate let navigationController = UINavigationController()
    var $: Dependencies!
    let window: UIWindow
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func pushFirstViewController(_ ofType: FirstViewController) {
        navigationController.isNavigationBarHidden = true
        if (ofType == .login) {
            pushLogin()
        } else {
            pushPlayer()
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func pushLogin(_ animated: Bool = true) {
        let viewModel = LoginViewModel(loginController: $.loginController, navigationService: self)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushPlayer(_ animated: Bool = true) {
        let viewModel = PlayerViewModel(rhapsody: $.rhapsody, navigationService: self)
        let viewController = PlayerViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushNowPlaying(_ player: Player, animated: Bool = true) {
        let viewModel = NowPlayingViewModel(player: player, navigationService: self)
        let viewController = NowPlayingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushDetails(_ player: Player, animated: Bool = true) {
        let viewModel = DetailsViewModel(player: player)
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}
