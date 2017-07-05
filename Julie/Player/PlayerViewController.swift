//
//  PlayerViewController.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class PlayerViewController: ViewController {
    
    var viewModel: PlayerViewModel!

    @IBOutlet weak var playButton: UIButton!
    
    convenience init(viewModel: PlayerViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playButton.layer.cornerRadius = playButton.frame.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.backgroundColor = .primary()
        playButton.tintColor = .action()
        playButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5.0, 0, 0)
        
        playButton.rx.tap
            .bind(to: viewModel.playTap)
            .addDisposableTo(bag)
        
        viewModel.loading
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: showLoading)
            .addDisposableTo(bag)
    }

}
