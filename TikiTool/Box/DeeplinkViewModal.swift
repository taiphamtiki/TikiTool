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

    func createListDeepLinkObssever() -> Observable<[BoxItem]> {
        return Observable.create { observer in
            FirebaseManager.shareInsstance.getDeepLink({ (listBox) in
                observer.onNext(listBox)
                self.boxs = listBox
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
}
