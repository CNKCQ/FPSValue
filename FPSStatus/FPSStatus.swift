//
//  Copyright © 2016年 Jack. All rights reserved.
//

import Foundation
import UIKit

typealias FPSValue = (Int) -> Void

public class FPSStatus {
    public static let shareInstance = FPSStatus()
    var displayLink: CADisplayLink?
    var lastTime: NSTimeInterval = 0
    var count: Int = 0
    var fpsValue: FPSValue?
    let fpsLabel = UILabel()

    init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(applicationDidBecomeActiveNotification), name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(applicationWillResignActiveNotification), name: UIApplicationWillResignActiveNotification, object: nil)

        // Track FPS using display link
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkTick(_:)))
        displayLink?.paused = true
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)

        // fpsLabel
        fpsLabel.frame = CGRect(x: 10, y: UIScreen.mainScreen().bounds.size.height - 114, width: 50, height: 20)
        fpsLabel.font = UIFont.boldSystemFontOfSize(12)
        fpsLabel.textColor = UIColor(red: 0.33, green: 0.84, blue: 0.43, alpha: 1)
        fpsLabel.backgroundColor = .blackColor()
        fpsLabel.alpha = 0.7
        fpsLabel.layer.cornerRadius = 4
        fpsLabel.clipsToBounds = true
        fpsLabel.textAlignment = .Center
        fpsLabel.tag = 102

    }

    @objc func displayLinkTick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        count += 1
        let interval = link.timestamp - lastTime
        if interval < 1 {
            return
        }
        lastTime = link.timestamp
        let fps = Float(count) / Float(interval)
        count = 0
        let text = "\(Int(round(fps))) FPS"

        fpsLabel.text = text
        if let closures = self.fpsValue {
            closures(Int(round(fps)))
        }
    }

    func open() {
        let rootVCSubviews = UIApplication.sharedApplication().delegate?.window!!.rootViewController!.view.subviews
        for label in rootVCSubviews! {
            if label.isKindOfClass(UILabel) && label.tag == 102 {
                return
            }
        }
        displayLink?.paused = false
        UIApplication.sharedApplication().keyWindow?.rootViewController?.view.addSubview(fpsLabel)
    }

    func openWithHandler(newFpsValue: FPSValue) {
        FPSStatus.shareInstance.open()
        fpsValue = newFpsValue
    }

    func close() {
        displayLink?.paused = true
            let rootVCSubviews = UIApplication.sharedApplication().delegate?.window!!.rootViewController!.view.subviews
        for label in rootVCSubviews! {
            if label.isKindOfClass(UILabel) && label.tag == 102 {
                label.removeFromSuperview()
                return
            }
        }

    }


    @objc func applicationDidBecomeActiveNotification() {
        displayLink?.paused = false
    }

    @objc func applicationWillResignActiveNotification() {
        displayLink?.paused = true
    }

    deinit {
        displayLink?.paused = true
    }
}
