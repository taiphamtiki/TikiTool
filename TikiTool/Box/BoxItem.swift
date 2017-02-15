//
//  BoxItem.swift
//  TikiTool
//
//  Created by ZickOne on 2/7/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation

public class BoxItem: NSObject {
    var name : String
    var link : String
    var isLike: Bool
    
    
    init(name : String, link : String,_ isLike:Bool) {
        self.name = name
        self.link = link
        self.isLike = isLike
    }
    
}
