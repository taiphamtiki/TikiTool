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
    func getDeepLink(_ onCompletion:@escaping (FIRDataSnapshot) -> Void) {
        deeplinkReef.observe(FIRDataEventType.value, with: { snapshot in
            onCompletion(snapshot)
        })
    }
    
}
