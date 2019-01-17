//
//  UnlockViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite

extension NSWindow {
    func shakeWindow(){
        let numberOfShakes          = 3
        let durationOfShake         = 0.7
        let vigourOfShake : CGFloat = 0.01
        let frame : CGRect = self.frame
        let shakeAnimation :CAKeyframeAnimation  = CAKeyframeAnimation()

        let shakePath = CGMutablePath()
        shakePath.move( to: CGPoint(x:NSMinX(frame), y:NSMinY(frame)))

        for _ in 0...numberOfShakes-1 {
            shakePath.addLine(to: CGPoint(x:NSMinX(frame) - frame.size.width * vigourOfShake, y:NSMinY(frame)))
            shakePath.addLine(to: CGPoint(x:NSMinX(frame) + frame.size.width * vigourOfShake, y:NSMinY(frame)))
        }

        shakePath.closeSubpath()
        shakeAnimation.path = shakePath
        shakeAnimation.duration = durationOfShake

        self.animations = ["frameOrigin":shakeAnimation]
        self.animator().setFrameOrigin(self.frame.origin)
    }
}

class UnlockViewController: NSViewController {
    @IBOutlet weak var masterPasswordTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func unlockApp() {
        if let masterPassword = KeychainWrapper.standard.string(forKey: "MasterPassword") {
            if masterPassword == masterPasswordTextField.stringValue {
                let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
                let viewController = storyboard.instantiateController(withIdentifier: "MainViewController") as! NSSplitViewController
                self.view.window?.contentViewController = viewController
            } else {
                self.view.window?.shakeWindow()
            }
        }
    }

    @IBAction func unlockPressed(_ sender: Any) {
        unlockApp()
    }
    
    @IBAction func enterPressed(_ sender: NSTextField) {
        unlockApp()
    }
}

