//
//  DetailsViewController.swift
//  Julie
//
//  Created by Ivan Blagajić on 06/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit
import RxDataSources
import RxOptional
import PureLayout

class DetailsViewController: ViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DetailsViewModel!
    
    convenience init(viewModel: DetailsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func setup() {
        super.setup()
        
        tableView.separatorColor = .clearColor()
        tableView.contentInset = UIEdgeInsets(top: 320.0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clearColor()
        viewModel.headerImage
            .asDriver(onErrorJustReturn: nil)
            .drive(headerImage.rx_image)
            .addDisposableTo(bag)
        
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = .Positional
        formatter.allowedUnits = [.Minute, .Second]
        formatter.zeroFormattingBehavior = .None
        let cellId = String(DetailsTableViewCell)
        tableView.registerNib(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        let dataSource = RxTableViewSectionedReloadDataSource<Section>()
        viewModel.sections
            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(bag)
        dataSource.configureCell = { [weak self] ds, tv, ip, i in
            let cell = self?.tableView.dequeueReusableCellWithIdentifier(cellId) as! DetailsTableViewCell
            cell.titleLabel?.text = i.name
            cell.timeLabel?.text = formatter.stringFromTimeInterval(NSTimeInterval(i.duration))
            return cell
        }
        viewModel.nowPlayingIndex
            .asDriver(onErrorJustReturn: nil)
            .filterNil()
            .map { NSIndexPath(forRow: $0, inSection: 0)}
            .driveNext { [weak self] ip in
                self?.tableView.selectRowAtIndexPath(ip, animated: true, scrollPosition: .None)
            }.addDisposableTo(bag)
        tableView.rx_itemSelected
            .bindTo(viewModel.selectTrack)
            .addDisposableTo(bag)
    }

}
