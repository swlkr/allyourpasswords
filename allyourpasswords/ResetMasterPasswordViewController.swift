//
//  ResetMasterPasswordViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/29/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite

class ResetMasterPasswordViewController : NSViewController {
    @IBOutlet weak var currentPasswordTextField: NSTextField!
    @IBOutlet weak var newPasswordTextField: NSTextField!
    @IBOutlet weak var confirmPasswordTextField: NSTextField!
    var db : Connection?

    override func viewDidLoad() {
        super.viewDidLoad()

        db = Database.open()
    }

    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let viewController = storyboard.instantiateController(withIdentifier: "MainViewController") as! MainViewController
        self.view.window?.contentViewController = viewController
    }

    @IBAction func okButtonClicked(_ sender: NSButton) {
        let masterPassword = KeychainWrapper.standard.string(forKey: "MasterPassword")

        if !newPasswordTextField.stringValue.isEmpty &&
           newPasswordTextField.stringValue == confirmPasswordTextField.stringValue &&
           currentPasswordTextField.stringValue == masterPassword ?? "" &&
           !(masterPassword ?? "").isEmpty &&
           KeychainWrapper.standard.set(newPasswordTextField.stringValue, forKey: "MasterPassword") {
            try! db?.rekey(newPasswordTextField.stringValue)

            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
            let viewController = storyboard.instantiateController(withIdentifier: "MainViewController") as! MainViewController
            self.view.window?.contentViewController = viewController
        } else {
            self.view.window?.shakeWindow()
        }
    }
}
