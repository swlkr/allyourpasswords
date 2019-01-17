//
//  SetMasterPasswordViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class SetMasterPasswordViewController: NSViewController {
    @IBOutlet weak var masterPasswordTextField: NSTextField!

    @IBAction func setPasswordClicked(_ sender: NSButton) {
        if masterPasswordTextField.stringValue.count > 0 {
            setMasterPassword(masterPasswordTextField.stringValue)
        }
    }

    @IBAction func masterPasswordTextFieldEnterPressed(_ sender: NSTextField) {
        if masterPasswordTextField.stringValue.count > 0 {
            setMasterPassword(masterPasswordTextField.stringValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setMasterPassword(_ masterPassword: String) {
        // set database key
        if let db = Database.open() {
            try! db.key(masterPassword)

            if KeychainWrapper.standard.set(masterPassword, forKey: "MasterPassword") {
                let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
                let viewController = storyboard.instantiateController(withIdentifier: "UnlockViewController") as! NSViewController
                self.view.window?.contentViewController = viewController
            }
        }
    }
}

