//
//  DeeplinkViewController.swift
//  TikiTool
//
//  Created by ZickOne on 2/27/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import GDPerformanceView_Swift
import TTSegmentedControl
import RxCocoa
import RxSwift

class DeeplinkViewController:UIViewController,BoxItemCellDelegate,UITableViewDelegate,UITableViewDataSource  {
    var deepLinkViewModel = DeeplinkViewModal()
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.tableView.register(UINib.init(nibName: "BoxItemCell", bundle: Bundle.main), forCellReuseIdentifier:  "BoxItemCell")
        self.tableView.tableFooterView = UIView()
        self.deepLinkViewModel.segmentObsever.subscribe(onNext: { (listBox) in
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag);

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    // MARK: - TableviewDataSourcess
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deepLinkViewModel.boxs.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let box = self.deepLinkViewModel.boxs[indexPath.row]
        let cell : BoxItemCell = tableView.dequeueReusableCell(withIdentifier: "BoxItemCell", for: indexPath) as! BoxItemCell
        
        cell.boxNameTitle.text = box.name
        let isHasSave = CoreDataHelper.shareInsstance.checkDeppLink(box: box)
        cell.favoritesBtn.isSelected = isHasSave
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let box = self.deepLinkViewModel.boxs[indexPath.row]
        
        let alertViewController = UIAlertController.init(title: "Thông Báo", message: String("Bạn có muốn chuyển tới \(box.name) ?"), preferredStyle: UIAlertControllerStyle.alert)
        alertViewController.addAction(UIAlertAction.init(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
        }))
        
        alertViewController.addAction(UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.cancel, handler: { (action) in
            let urlBox = box.link
            UIApplication.shared.open(URL.init(string: urlBox)!, options: [:], completionHandler: nil)
        }))
        
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func didClickItem(box: BoxItemCell) {
        let indexCell = self.tableView.indexPath(for: box)
        let itemBox = self.deepLinkViewModel.boxs[(indexCell?.row)!]
        let coreDataHelper = CoreDataHelper()
        let isHasSave = CoreDataHelper.shareInsstance.checkDeppLink(box: itemBox)
        if isHasSave == false {
            coreDataHelper.Save(box: itemBox)
        }
        else {
            coreDataHelper.removeDeepLink(box: itemBox)
        }
    }

}
