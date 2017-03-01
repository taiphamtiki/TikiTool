//
//  LoveViewModal.swift
//  TikiTool
//
//  Created by ZickOne on 2/28/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
class LoveViewModal {
    var boxs = [BoxItem]()

    func createListDBObssever() -> Observable<[BoxItem]> {
        return Observable.create { observer in
           self.boxs = CoreDataHelper().fetch(entityStr: "DeepLink")
            observer.onCompleted()

            return Disposables.create()
        }
    }
}
