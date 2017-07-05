//
//  ViewController.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit
import RxSwift
import RxOptional

class ViewController: UIViewController {
    
    let activityIndicatorContainer = UIView()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicatorContainer.frame = view.bounds
        activityIndicator.center = activityIndicatorContainer.center
    }
    
    func setup() {
        activityIndicatorContainer.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        activityIndicatorContainer.addSubview(activityIndicator)
        activityIndicatorContainer.isHidden = true
        view.addSubview(activityIndicatorContainer)
    }
    
    func setStyle() {
        view.backgroundColor = .standardBackground()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .primary()
        navigationItem.leftBarButtonItem?.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).addDisposableTo(bag)
    }
    
    func showLoading(_ show: Bool) {
        activityIndicatorContainer.isHidden = !show
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

}
