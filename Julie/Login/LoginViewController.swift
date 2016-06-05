//
//  LoginViewController.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {

    @IBOutlet weak var emailImage: ImageView!
    @IBOutlet weak var usernameInput: TextField!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var passwordImage: ImageView!
    @IBOutlet weak var passwordInput: TextField!
    @IBOutlet weak var loginButton: RectButton!
    
    var viewModel: LoginViewModel!
    
    convenience init(viewModel: LoginViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        divider.backgroundColor = UIColor.primaryColor()
        
        usernameInput.rx_text
            .bindTo(viewModel.username)
            .addDisposableTo(bag)
        passwordInput.rx_text
            .bindTo(viewModel.password)
            .addDisposableTo(bag)
        loginButton.rx_tap
            .bindTo(viewModel.loginTap)
            .addDisposableTo(bag)
        
        viewModel.validatedUsername
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? 1.0 : 0.5 }
            .drive(emailImage.rx_alpha)
            .addDisposableTo(bag)
        viewModel.validatedPassword
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? 1.0 : 0.5 }
            .drive(passwordImage.rx_alpha)
            .addDisposableTo(bag)
        viewModel.loginEnabled
            .asDriver(onErrorJustReturn: false)
            .drive(loginButton.rx_enabled)
            .addDisposableTo(bag)
        viewModel.loggingIn
            .asDriver(onErrorJustReturn: false)
            .driveNext(showLoading)
            .addDisposableTo(bag)
#if DEBUG
        usernameInput.text = "ivan.blagajic@gmail.com"
        passwordInput.text = "sdf69nts"
#endif
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicatorContainer.frame = view.bounds
        activityIndicator.center = activityIndicatorContainer.center
    }

}
