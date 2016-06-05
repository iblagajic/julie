//
//  NowPlayingViewController.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class NowPlayingViewController: ViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nowPlayingLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: NowPlayingViewModel!
    
    convenience init(viewModel: NowPlayingViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.albumImage
            .asDriver(onErrorJustReturn: nil)
            .drive(backgroundImage.rx_image)
            .addDisposableTo(bag)
        viewModel.albumImage
            .asDriver(onErrorJustReturn: nil)
            .drive(albumImage.rx_image)
            .addDisposableTo(bag)
        viewModel.nowPlayingTitle
            .asDriver(onErrorJustReturn: "")
            .drive(nowPlayingLabel.rx_text)
            .addDisposableTo(bag)
        viewModel.artistName
            .asDriver(onErrorJustReturn: "")
            .drive(artistNameLabel.rx_text)
            .addDisposableTo(bag)
        viewModel.trackName
            .asDriver(onErrorJustReturn: "")
            .drive(trackNameLabel.rx_text)
            .addDisposableTo(bag)
        previousButton.rx_tap
            .bindTo(viewModel.previousTap)
            .addDisposableTo(bag)
        pauseButton.rx_tap
            .bindTo(viewModel.playPauseTap)
            .addDisposableTo(bag)
        nextButton.rx_tap
            .bindTo(viewModel.nextTap)
            .addDisposableTo(bag)
    }
    
    override func setStyle() {
        super.setStyle()
        
        nowPlayingLabel.font = UIFont.h2()
        artistNameLabel.font = UIFont.microBold()
        trackNameLabel.font = UIFont.bigRegular()
        nowPlayingLabel.textColor = UIColor.primaryColor()
        artistNameLabel.textColor = UIColor.primaryColor()
        trackNameLabel.textColor = UIColor.primaryColor()
        
        albumImage.layer.cornerRadius = albumImage.frame.size.width/2
        albumImage.layer.borderWidth = 2.0
        albumImage.layer.borderColor = UIColor.standardBackgroundColor().CGColor
        albumImage.layer.masksToBounds = true
        
        previousButton.tintColor = UIColor.primaryColor()
        pauseButton.tintColor = UIColor.primaryColor()
        nextButton.tintColor = UIColor.primaryColor()
    }

}
