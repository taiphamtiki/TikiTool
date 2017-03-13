//
//  DiskSpaceViewController.swift
//  TikiTool
//
//  Created by ZickOne on 2/15/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import UIKit
import Luminous
class DiskSpaceViewController: UIViewController {
    var totalDiskSpace : Int?
    @IBOutlet weak var parentIndicator: UIView!
    @IBOutlet weak var infoDiskLable: UILabel!
    var timer : Timer?
    let maxTime = 15.0
    var timeCount = 0.0
    var currentDiskSpace : Int?
    let waveLoadingIndicator: WaveLoadingIndicator = WaveLoadingIndicator(frame: CGRect.zero)

    override func viewDidLoad() {
        // MARK: Disk
        printDiskSpace()
        self.waveLoadingIndicator.frame = self.parentIndicator.bounds
        self.waveLoadingIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.parentIndicator.addSubview(self.waveLoadingIndicator)
        self.waveLoadingIndicator.progress = 0.5
        let value : Double = Double(Luminous.System.Disk.usedSpaceInBytes) * 100.0 / Double(Luminous.System.Disk.totalSpaceInBytes)
        self.waveLoadingIndicator.progress = ( value / 100.0)
        self.infoDiskLable.text = String("\(Luminous.System.Disk.usedSpace)/" + "\(Luminous.System.Disk.totalSpace)")
    }
    
    @IBAction func actionClear(_ sender: Any) {
        self.freeDisk(sender)
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionTime), userInfo: nil, repeats: true)

    }
    func actionTime() {
        if (self.waveLoadingIndicator.progressReload <= 1){
            self.timeCount += 1.0
            let percent = (Double(self.timeCount) / maxTime)
            self.waveLoadingIndicator.progressReload = percent
            print("My percent \(percent)")
        } else {
            self.timer?.invalidate()
            self.waveLoadingIndicator.progressReload = 0

            self.infoDiskLable.text = String("\(Luminous.System.Disk.usedSpace)/" + "\(Luminous.System.Disk.totalSpace)")

        }
    }
    func printDiskSpace()  {
        print("------------\nDisk\n------------")
        print("freeSpace: \(Luminous.System.Disk.freeSpace)")
        print("freeSpaceInBytes: \(Luminous.System.Disk.freeSpaceInBytes)")
        print("totalSpace: \(Luminous.System.Disk.totalSpace)")
        print("totalSpaceInBytes: \(Luminous.System.Disk.totalSpaceInBytes)")
        print("usedSpace: \(Luminous.System.Disk.usedSpace)")
        print("usedSpaceInBytes: \(Luminous.System.Disk.usedSpaceInBytes)")

    }
    @IBAction func freeDisk(_ sender: Any) {
        print("-------------------First-----------------")
        printDiskSpace()
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        FileManager.default.createFile(atPath: "\(documentsPath)/xfile.txt", contents: Data(), attributes: [:])
            _ = truncate("\(documentsPath)/xfile.txt",Luminous.System.Disk.freeSpaceInBytes );
            print("-------------------After-----------------")
            printDiskSpace()
            try! FileManager.default.removeItem(atPath: "\(documentsPath)/xfile.txt")
            self.printDiskSpace()
    }
    
}
