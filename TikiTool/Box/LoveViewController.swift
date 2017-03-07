//
//  LoveViewController.swift
//  TikiTool
//
//  Created by ZickOne on 2/28/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import GDPerformanceView_Swift
import TTSegmentedControl
import RxCocoa
import RxSwift

class LoveViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var loveTableview: UITableView!
    var loveViewModel = LoveViewModal()
    
    override func viewDidLoad() {
        self.loveTableview.register(UINib.init(nibName: "BoxItemCell", bundle: Bundle.main), forCellReuseIdentifier:  "BoxItemCell")
        self.loveViewModel.createListDBObssever().subscribe(onCompleted: {
            self.loveTableview.reloadData()
        }).addDisposableTo(DisposeBag())
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.loveViewModel.createListDBObssever().subscribe(onCompleted: {
            self.loveTableview.reloadData()
        }).addDisposableTo(DisposeBag())

    }
    
    // MARK: - TableviewDataSourcess
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loveViewModel.boxs.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let box = self.loveViewModel.boxs[indexPath.row]
        let cell : BoxItemCell = tableView.dequeueReusableCell(withIdentifier: "BoxItemCell", for: indexPath) as! BoxItemCell
        cell.favoritesBtn.isHidden = true
        cell.boxNameTitle.text = box.name
        
        return cell
    }

}
