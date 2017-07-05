//
//  LoginViewController.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {

    @IBOutlet weak var logo: ImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var emailImage: ImageView!
    @IBOutlet weak var usernameInput: TextField!
    @IBOutlet var dividers: [UIView]!
    @IBOutlet weak var passwordImage: ImageView!
    @IBOutlet weak var passwordInput: TextField!
    @IBOutlet weak var loginButton: RectButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: LoginViewModel!
    
    convenience init(viewModel: LoginViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }
    
    override func setStyle() {
        super.setStyle()
        
        dividers.forEach { divider in
            divider.backgroundColor = .secondary()
        }
    }
    
    override func setup() {
        super.setup()

        usernameInput.rx.text.orEmpty
            .bind(to: viewModel.username)
            .addDisposableTo(bag)
        passwordInput.rx.text.orEmpty
            .bind(to: viewModel.password)
            .addDisposableTo(bag)
        loginButton.rx.tap
            .bind(to: viewModel.loginTap)
            .addDisposableTo(bag)
        
        viewModel.validatedUsername
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? 1.0 : 0.5 }
            .drive(emailImage.rx.alpha)
            .addDisposableTo(bag)
        viewModel.validatedPassword
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? 1.0 : 0.5 }
            .drive(passwordImage.rx.alpha)
            .addDisposableTo(bag)
        viewModel.loginEnabled
            .asDriver(onErrorJustReturn: false)
            .drive(loginButton.rx.isEnabled)
            .addDisposableTo(bag)
        viewModel.loggingIn
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: showLoading)
            .addDisposableTo(bag)
        viewModel.loggingIn.filter { $0 == true }
            .mapVoid()
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.usernameInput.resignFirstResponder()
                self?.passwordInput.resignFirstResponder()
            }).addDisposableTo(bag)
        
        rx_keyboardWillChange
            .asDriver(onErrorJustReturn: .zero)
            .drive(onNext: { [weak self] rect in
                UIView.animate(withDuration: 0.3) {
                    let keyboardHeight = rect.height
                    let containerHeight = self?.container.frame.height ?? 0
                    let viewHeight = self?.view.frame.height ?? 0
                    self?.logo.alpha = keyboardHeight > 0 ? 0.0 : 1.0
                    self?.bottomConstraint.constant = keyboardHeight > 0 ? keyboardHeight + (viewHeight - keyboardHeight - containerHeight) / 2  : 55.0
                    self?.view.layoutIfNeeded()
                }
            }).addDisposableTo(bag)
    }

}
