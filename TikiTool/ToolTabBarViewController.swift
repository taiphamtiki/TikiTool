//
//  ToolTabBarViewController.swift
//  TikiTool
//
//  Created by ZickOne on 2/21/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import UIKit
class ToolTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.init(colorLiteralRed: 71/255.0, green: 77/255.0, blue: 87/255.0, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 131/255.0, green: 189/255.0, blue: 74/255.0, alpha: 1.0)
//        [[UITabBar appearance] setSelectedImageTintColor:[UIColor greenColor]]; // for selected items that are green

    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 56
        tabFrame.origin.y = self.view.frame.size.height - 56
        self.tabBar.frame = tabFrame
        
    }
}
