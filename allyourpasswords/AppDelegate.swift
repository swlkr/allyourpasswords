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

    func applicationWillFinishLaunching(_ notification: Notification) {
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let window = storyboard.instantiateController(withIdentifier: "WindowController") as! NSWindowController
        let masterPassword: String? = KeychainWrapper.standard.string(forKey: "MasterPassword")
        if masterPassword == nil {
            let viewController = storyboard.instantiateController(withIdentifier: "SetMasterPasswordViewController") as! NSViewController
            window.contentViewController = viewController
        } else {
            let viewController = storyboard.instantiateController(withIdentifier: "UnlockViewController") as! NSViewController
            window.contentViewController = viewController
        }
        window.showWindow(self)
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
}

