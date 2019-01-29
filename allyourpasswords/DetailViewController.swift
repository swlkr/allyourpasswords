//
//  DetailViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/18/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite

class DetailViewController : NSViewController {

    var row : Row?
    let login = Login()
    @IBOutlet weak var nameOrUrl: NSTextField!
    @IBOutlet weak var favicon: NSImageView!
    @IBOutlet weak var email: NSTextField!
    @IBOutlet weak var username: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!
    @IBOutlet weak var toolbarView: NSView!
    @IBOutlet weak var plaintText: NSTextField!
    @IBOutlet weak var showButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let emailValue = row?[login.email]
        if (emailValue ?? "").isEmpty {
            email.stringValue = "---"
        } else {
            email.stringValue = emailValue!
        }

        let usernameValue = row?[login.username]
        if (usernameValue ?? "").isEmpty {
            username.stringValue = "---"
        } else {
            username.stringValue = usernameValue!
        }

        let nameValue = row?[login.name]
        if (nameValue ?? "").isEmpty {
            nameOrUrl.stringValue = row?[login.url] ?? "---"
        } else {
            nameOrUrl.stringValue = nameValue!
        }

        let passwordValue = row?[login.password]
        if (passwordValue ?? "").isEmpty {
            password.stringValue = "---"
        } else {
            password.stringValue = row?[login.password] ?? ""
        }

        let path = NSSearchPathForDirectoriesInDomains(
            .applicationSupportDirectory, .userDomainMask, true
            ).first! + "/"  + Bundle.main.bundleIdentifier!
        let url = URL(string: row?[login.url] ?? "")
        let domain = url?.host
        let str = "\(path)/\(domain ?? "").png"
        let image = NSImage(contentsOfFile: str)
        favicon.image = image
    }

    @IBAction func editButtonClicked(_ sender: NSButton) {
        let container = self.parent as! ContainerViewController
        container.row = row
        container.isNew = false
        container.showEditViewController()
    }

    func copyToPasteBoard(_ string: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(string, forType: .string)
    }

    @IBAction func copyEmailClicked(_ sender: NSButton) {
        copyToPasteBoard(email.stringValue)
    }

    @IBAction func copyPasswordClicked(_ sender: NSButton) {
        copyToPasteBoard(password.stringValue)
    }
    
    @IBAction func copyUsernameClicked(_ sender: NSButton) {
        copyToPasteBoard(username.stringValue)
    }
    @IBAction func showButtonClicked(_ sender: NSButton) {
        plaintText.stringValue = password.stringValue
        plaintText.isHidden = !plaintText.isHidden
        password.isHidden = !password.isHidden
        if plaintText.isHidden {
            showButton.title = "Show"
        } else {
            showButton.title = "Hide"
        }
    }
}
