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
        if KeychainWrapper.standard.set(masterPassword, forKey: "MasterPassword") {
            let db = Database.open()
            let login = Login()

            try! db.run(login.table.create(ifNotExists: true) { t in
                t.column(login.id, primaryKey: true)
                t.column(login.name)
                t.column(login.username)
                t.column(login.email)
                t.column(login.url)
                t.column(login.password)
            })

            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
            let viewController = storyboard.instantiateController(withIdentifier: "MainViewController") as! MainViewController
            self.view.window?.contentViewController = viewController
        }
    }
}

