//
//  FirebaseManager.swift
//  TikiTool
//
//  Created by ZickOne on 2/9/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import Firebase
class FirebaseManager: NSObject {
    static let shareInsstance = FirebaseManager()
    let deeplinkReef = FIRDatabase.database().reference().child("deeplink")
    func getDeepLink(_ onCompletion:@escaping ([BoxItem]) -> Void) {
        deeplinkReef.observe(FIRDataEventType.value, with: { snapshot in
            if snapshot.value == nil {
                onCompletion([])
            }
            
            var deepLink = [BoxItem]()
            for value in snapshot.children {
                let child = value as! FIRDataSnapshot
                let dict = child.value as! NSDictionary
                let deeplink = BoxItem(name: dict["title"] as! String, link: dict["link"] as! String,false)
                deepLink += [deeplink]
            }

            onCompletion(deepLink)
        })
    }
    
}
