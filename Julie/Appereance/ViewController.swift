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
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
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
        activityIndicatorContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        activityIndicatorContainer.addSubview(activityIndicator)
        activityIndicatorContainer.hidden = true
        view.addSubview(activityIndicatorContainer)
    }
    
    func setStyle() {
        view.backgroundColor = .standardBackground()
    }
    
    func showLoading(show: Bool) {
        activityIndicatorContainer.hidden = !show
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

}
