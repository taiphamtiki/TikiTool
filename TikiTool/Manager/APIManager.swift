//
//  AP/Users/zickone/Desktop/TikiTool/TikiToolIManager.swift
//  TikiTool
//
//  Created by ZickOne on 2/7/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
class APIManager: NSObject {
    static let shareInstance = APIManager()
    func getListBox(onCompletion: (_ result: [BoxItem]) -> Void) {
        //product and dev box
        let productionBox = BoxItem(name: "Box Product",link: "tikivn://endpoint/?url=https://mapi.tiki.vn",true)
        let devBox =  BoxItem(name: "Box Dev", link: "tikivn://endpoint/?url=http://mapi.tala.xyz",true)
        var boxs = [BoxItem]()
        boxs += [productionBox,devBox]
        
        //Other box
        for i in 1...50 {
            let box = BoxItem(name:String(format:"Box %2d",i),link:String(format :"tikivn://endpoint/?url=http://api.box%02d.tala.xyz",i),true)
            boxs += [box]
        }
        //onCompletion
        onCompletion(boxs)
        
    }
    

}
