//
//  AppDelegate.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window : NSWindowController?
    var storyboard : NSStoryboard?
    @IBOutlet weak var changeMasterPasswordMenuItem: NSMenuItem!

    func applicationWillFinishLaunching(_ notification: Notification) {
        NotificationCenter.default.addObserver(self, selector: #selector(enableChangeMasterPasswordMenuItem), name: NSNotification.Name(rawValue: "enableChangeMasterPasswordMenuItem"), object: nil)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        changeMasterPasswordMenuItem.isEnabled = false

        storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        window = storyboard?.instantiateController(withIdentifier: "WindowController") as? NSWindowController
        let masterPassword: String? = KeychainWrapper.standard.string(forKey: "MasterPassword")
        if masterPassword == nil {
            let viewController = storyboard?.instantiateController(withIdentifier: "SetMasterPasswordViewController") as! SetMasterPasswordViewController
            window?.contentViewController = viewController
        } else {
            let viewController = storyboard?.instantiateController(withIdentifier: "UnlockViewController") as! UnlockViewController
            window?.contentViewController = viewController
        }

        window?.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func addNewLogin(_ sender: NSMenuItem) {
    }

    @IBAction func deleteLogin(_ sender: NSMenuItem) {
    }

    @IBAction func copy(_ sender: NSMenuItem) {
    }

    @IBAction func copyEmailOrUsername(_ sender: NSMenuItem) {
    }

    @IBAction func copyPassword(_ sender: NSMenuItem) {
    }

    @IBAction func changeMasterPassword(_ sender: NSMenuItem) {
        if window?.contentViewController is UnlockViewController ||
           window?.contentViewController is SetMasterPasswordViewController {
            return
        }

        let viewController = storyboard?.instantiateController(withIdentifier: "ResetMasterPasswordViewController") as! ResetMasterPasswordViewController
        window?.contentViewController = viewController
    }

    @objc func enableChangeMasterPasswordMenuItem() {
        changeMasterPasswordMenuItem.isEnabled = true
    }
}

