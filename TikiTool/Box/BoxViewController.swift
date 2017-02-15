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
class BoxViewController: UIViewController,UITableViewDelegate  {
    @IBOutlet weak var boxTableView: UITableView!
    @IBOutlet weak var segmentType: UISegmentedControl!
    var boxViewModel : BoxViewModel?
    static let identifier = String(describing: BoxItemCell.self)
    var lastestDataBox : Observable <Int> {
        return segmentType.rx.selectedSegmentIndex
        .distinctUntilChanged()
    }
    

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boxViewModel = BoxViewModel(listBoxObsever: self.lastestDataBox)
        self.boxViewModel?
        .lastListBox()
            .bindTo(boxTableView.rx.items){ tableView,row,item in
                let cell : BoxItemCell = tableView.dequeueReusableCell(withIdentifier: "BoxItemCell", for: IndexPath(row:row,section:0)) as! BoxItemCell
                return cell
                
        }
        .addDisposableTo(DisposeBag())
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        self.navigationController?.hidesNavigationBarHairline = true
    }
    
// MARK: - TableviewDataSourcess
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return boxViewModel.boxs.count
//    }
//    
//    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let box = self.boxViewModel.boxs[indexPath.row]
//        let cell : BoxItemCell = tableView.dequeueReusableCell(withIdentifier: "BoxItemCell", for: indexPath) as! BoxItemCell
//        
//       cell.boxNameTitle.text = box.name
//       
//        return cell
//    }
//    
//    // MARK: - TableViewDelegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let box = self.boxViewModel.boxs[indexPath.row]
//        
//        let alertViewController = UIAlertController.init(title: "Thông Báo", message: String("Bạn có muốn chuyển tới \(box.name) ?"), preferredStyle: UIAlertControllerStyle.alert)
//        alertViewController.addAction(UIAlertAction.init(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
//        }))
//        
//        alertViewController.addAction(UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.cancel, handler: { (action) in
//            let urlBox = box.link
//            UIApplication.shared.open(URL.init(string: urlBox)!, options: [:], completionHandler: nil)
//        }))
//        
//        
//        self.present(alertViewController, animated: true, completion: nil)
//        
//    }
// MARK - UISegmentControl
}
