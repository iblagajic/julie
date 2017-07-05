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
    @IBOutlet weak var albumImageButton: FillableRoundButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: NowPlayingViewModel!
    
    convenience init(viewModel: NowPlayingViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func setStyle() {
        super.setStyle()
        
        nowPlayingLabel.font = .h1()
        artistNameLabel.font = .microBold()
        trackNameLabel.font = .bigRegular()
        nowPlayingLabel.textColor = .primary()
        artistNameLabel.textColor = .primary()
        trackNameLabel.textColor = .primary()
        albumImageButton.tintColor = .action()
        previousButton.tintColor = .primary()
        playPauseButton.tintColor = .primary()
        nextButton.tintColor = .primary()
    }
    
    override func setup() {
        super.setup()
        
        viewModel.albumImage
            .asDriver(onErrorJustReturn: nil)
            .drive(backgroundImage.rx.image)
            .addDisposableTo(bag)
        viewModel.albumImage
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] image in
                self?.albumImageButton.setImage(image, for: .normal)
            }).addDisposableTo(bag)
        viewModel.nowPlayingTitle
            .asDriver(onErrorJustReturn: "")
            .drive(nowPlayingLabel.rx.text)
            .addDisposableTo(bag)
        viewModel.artistName
            .asDriver(onErrorJustReturn: "")
            .drive(artistNameLabel.rx.text)
            .addDisposableTo(bag)
        viewModel.trackName
            .asDriver(onErrorJustReturn: "")
            .drive(trackNameLabel.rx.text)
            .addDisposableTo(bag)
        viewModel.canNext
            .asDriver(onErrorJustReturn: false)
            .drive(nextButton.rx.isEnabled)
            .addDisposableTo(bag)
        viewModel.canPrevious
            .asDriver(onErrorJustReturn: false)
            .drive(previousButton.rx.isEnabled)
            .addDisposableTo(bag)
        viewModel.canPause
            .asDriver(onErrorJustReturn: false)
            .drive(playPauseButton.rx.isSelected)
            .addDisposableTo(bag)
        viewModel.progress
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: albumImageButton.rx_progress)
            .addDisposableTo(bag)
        previousButton.rx.tap
            .bind(to: viewModel.previousTap)
            .addDisposableTo(bag)
        playPauseButton.rx.tap
            .bind(to: viewModel.playPauseTap)
            .addDisposableTo(bag)
        nextButton.rx.tap
            .bind(to: viewModel.nextTap)
            .addDisposableTo(bag)
        albumImageButton.rx.tap
            .bind(to: viewModel.albumImageTap)
            .addDisposableTo(bag)
    }

}
