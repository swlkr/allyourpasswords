//
//  UnlockViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite
import LocalAuthentication

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

        showTouchID()
    }
    @IBAction func unlockWithTouchID(_ sender: NSButton) {
        showTouchID()
    }

    func showTouchID() {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"
        context.localizedFallbackTitle = "Unlock with password"

        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "unlock AllYourPasswords"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason ) { success, error in

                if success {
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        self.showPasswords()
                    }

                } else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                }
            }
        }
    }

    func showPasswords() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let viewController = storyboard.instantiateController(withIdentifier: "MainViewController") as! NSSplitViewController
        self.view.window?.contentViewController = viewController

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableChangeMasterPasswordMenuItem"), object: nil)
    }

    func unlockApp() {
        if let masterPassword = KeychainWrapper.standard.string(forKey: "MasterPassword") {
            if masterPassword == masterPasswordTextField.stringValue {
                showPasswords()
            } else {
                self.view.window?.shakeWindow()
            }
        }
    }

    @IBAction func unlockPressed(_ sender: NSButton) {
        unlockApp()
    }
    
    @IBAction func enterPressed(_ sender: NSTextField) {
        unlockApp()
    }
}

