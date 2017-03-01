//
//  BoxViewModel.swift
//  TikiTool
//
//  Created by ZickOne on 2/7/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
class BoxViewModel {
    var segmentObsever : Observable<[BoxItem]>!
    var boxs = [BoxItem]()
    init() {
        setup()
    }
    
    func setup()
    {
        self.segmentObsever = createListBoxObssever()

    }

    func createListBoxObssever() -> Observable<[BoxItem]> {
    return Observable.create { observer in
        APIManager.shareInstance.getListBox(onCompletion: { (listBox) in
            observer.onNext(listBox)
            self.boxs = listBox
            observer.onCompleted()
        })
        return Disposables.create()
    }
  }
}
    
    

