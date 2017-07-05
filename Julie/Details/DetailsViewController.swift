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
    
    @IBOutlet weak var tableView: UITableView!
    
    let headerView = DetailsHeaderView()
    
    var viewModel: DetailsViewModel!
    
    convenience init(viewModel: DetailsViewModel) {
        self.init()
        self.viewModel = viewModel
        let backImage = UIImage(named: "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = tableView.frame.width
        headerView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        tableView.tableHeaderView = headerView
    }
    
    override func setup() {
        super.setup()
        
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        
        viewModel.headerImage
            .asDriver(onErrorJustReturn: nil)
            .driveNext { [weak self] headerImage in
                self?.headerView.imageView.image = headerImage
                self?.tableView.tableHeaderView = self?.headerView
            }.addDisposableTo(bag)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = DateComponentsFormatter.ZeroFormattingBehavior()
        let cellId = String(describing: DetailsTableViewCell)
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
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
            .map { IndexPath(forRow: $0, inSection: 0)}
            .driveNext { [weak self] ip in
                self?.tableView.selectRowAtIndexPath(ip, animated: true, scrollPosition: .None)
            }.addDisposableTo(bag)
        tableView.rx_itemSelected
            .bindTo(viewModel.selectTrack)
            .addDisposableTo(bag)
    }

}
