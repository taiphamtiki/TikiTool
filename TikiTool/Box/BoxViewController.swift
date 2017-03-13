//
//  BoxViewController.swift
//  TikiTool
//
//  Created by ZickOne on 2/7/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import GDPerformanceView_Swift
import TTSegmentedControl
import RxCocoa
import RxSwift
class BoxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,BoxItemCellDelegate  {
    @IBOutlet weak var boxTableView: UITableView!
    @IBOutlet weak var segmentType: UISegmentedControl!
    var boxViewModel = BoxViewModel()
    static let identifier = String(describing: BoxItemCell.self)
    var lastestDataBox : Observable <Int> {
        return segmentType.rx.selectedSegmentIndex
        .distinctUntilChanged()
    }
    

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boxTableView.register(UINib.init(nibName: "BoxItemCell", bundle: Bundle.main), forCellReuseIdentifier:  "BoxItemCell")
        self.boxViewModel.createListBoxObssever().subscribe(onCompleted: {
            self.boxTableView.reloadData()
        }).addDisposableTo(DisposeBag())
        self.boxTableView.delegate = self
        self.setStatusBarStyle(UIStatusBarStyleContrast)
    }
    
// MARK: - TableviewDataSourcess
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxViewModel.boxs.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let box = self.boxViewModel.boxs[indexPath.row]
        let cell : BoxItemCell = tableView.dequeueReusableCell(withIdentifier: "BoxItemCell", for: indexPath) as! BoxItemCell
        
       cell.boxNameTitle.text = box.name
        let isHasSave = CoreDataHelper.shareInsstance.checkDeppLink(box: box)
        cell.favoritesBtn.isSelected = isHasSave
       cell.delegate = self
        return cell
    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let box = self.boxViewModel.boxs[indexPath.row]
        
        let alertViewController = UIAlertController.init(title: "Thông Báo", message: String("Bạn có muốn chuyển tới \(box.name) ?"), preferredStyle: UIAlertControllerStyle.alert)
        alertViewController.addAction(UIAlertAction.init(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
        }))
        
        alertViewController.addAction(UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.cancel, handler: { (action) in
            let urlBox = box.link
            UIApplication.shared.open(URL.init(string: urlBox)!, options: [:], completionHandler: nil)
        }))
        
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
// MARK - UISegmentControl
    func didClickItem(box: BoxItemCell) {
        let indexCell = self.boxTableView.indexPath(for: box)
        let itemBox = self.boxViewModel.boxs[(indexCell?.row)!]
        let coreDataHelper = CoreDataHelper()
        let isHasSave = CoreDataHelper.shareInsstance.checkDeppLink(box: itemBox)
        if isHasSave == false {
            coreDataHelper.Save(box: itemBox)
        }
        else {
            coreDataHelper.removeDeepLink(box: itemBox)
        }
        print(indexCell)
    }
}
