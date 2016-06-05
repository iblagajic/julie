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
    
    convenience init(playerViewModel: PlayerViewModel) {
        self.init()
        self.viewModel = playerViewModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playButton.layer.cornerRadius = playButton.frame.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.backgroundColor = UIColor.primaryColor()
        playButton.tintColor = UIColor.actionColor()
        playButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5.0, 0, 0)
        
        playButton.rx_tap
            .bindTo(viewModel.playTap)
            .addDisposableTo(bag)
    }

}
