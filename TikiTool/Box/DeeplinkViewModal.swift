//
//  DeeplinkViewModal.swift
//  TikiTool
//
//  Created by ZickOne on 2/27/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

class DeeplinkViewModal {
    var boxs = [BoxItem]()
    var segmentObsever : Observable<[BoxItem]>!
    
    init() {
        setup()
    }
    
    func setup()
    {
        self.segmentObsever = createListDeepLinkObssever()
        
    }
    func createListDeepLinkObssever() -> Observable<[BoxItem]> {
        return Observable.create { observer in
            FirebaseManager.shareInsstance.getDeepLink({ (listBox) in
                self.boxs = listBox
                observer.onNext(listBox)
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
}
