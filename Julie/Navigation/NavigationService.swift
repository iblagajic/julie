//
//  NavigationService.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

enum FirstViewController {
    case Login
    case Player
}

class NavigationService {
    
    private let navigationController = UINavigationController()
    var $: Dependencies!
    let window: UIWindow
    
    init() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    }
    
    func pushFirstViewController(ofType: FirstViewController) {
        navigationController.navigationBarHidden = true
        if (ofType == .Login) {
            pushLogin()
        } else {
            pushPlayer()
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func pushLogin(animated: Bool = true) {
        let viewModel = LoginViewModel(loginController: $.loginController, navigationService: self)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushPlayer(animated: Bool = true) {
        let viewModel = PlayerViewModel(rhapsody: $.rhapsody, navigationService: self)
        let viewController = PlayerViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushNowPlaying(player: Player, animated: Bool = true) {
        let viewModel = NowPlayingViewModel(player: player, navigationService: self)
        let viewController = NowPlayingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pushDetails(player: Player, animated: Bool = true) {
        let viewModel = DetailsViewModel(player: player)
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}
