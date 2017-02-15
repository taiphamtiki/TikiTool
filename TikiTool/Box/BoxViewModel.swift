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
import ObservableArray_RxSwift
import Firebase
class BoxViewModel {
    var boxs = ObservableArray<BoxItem>()
    var segmentObsever : Observable <Int>!
    
    init(listBoxObsever :Observable <Int> ) {
        self.segmentObsever = listBoxObsever
    }
    
    func lastListBox() -> Observable <[BoxItem]> {
        return segmentObsever
            .observeOn(MainScheduler.instance)
            .flatMapLatest{selectedSegmentIndex-> Observable<[BoxItem]> in
                print(selectedSegmentIndex)
                return self.createListBoxObssever()
            }
        
    }
   private func createListBoxObssever() -> Observable<[BoxItem]> {
        return Observable.create { observer in
            APIManager.shareInstance.getListBox(onCompletion: { (listBox) in
                observer.onNext(listBox)
                observer.onCompleted()
            })
            return Disposables.create()
        }
      }
    
//    public func getDeeplink() {
//        
//            FirebaseManager.shareInsstance.getDeepLink({ (snapshot) in
//                self.boxs = [BoxItem]()
//                
//                if snapshot.value == nil {
//                    return
//                }
//                
//                for value in snapshot.children {
//                    let child = value as! FIRDataSnapshot
//                    let dict = child.value as! NSDictionary
//                    let deeplink = BoxItem(name: dict["title"] as! String, link: dict["link"] as! String, false)
//                    self.boxs += [deeplink]
//                }
//            })
//        }
    }
    
    

