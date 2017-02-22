//
//  BoxItemCell.swift
//  TikiTool
//
//  Created by ZickOne on 2/8/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import UIKit
import FaveButton
class BoxItemCell: UITableViewCell  {
    @IBOutlet weak var boxNameTitle: UILabel!
    @IBOutlet weak var favoritesBtn: FaveButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.init(colorLiteralRed: 22/255.0, green: 28/255.0, blue: 37/255.0, alpha: 1)
        self.contentView.backgroundColor = UIColor.init(colorLiteralRed: 22/255.0, green: 28/255.0, blue: 37/255.0, alpha: 1)

    }
    
}
