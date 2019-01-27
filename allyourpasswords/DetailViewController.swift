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
    var tableViewController : TableViewController?
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
        if emailValue?.count ?? 0 > 0 {
            email.stringValue = emailValue!
        } else {
            email.stringValue = "---"
        }

        let usernameValue = row?[login.username]
        if usernameValue?.count ?? 0 > 0 {
            username.stringValue = usernameValue!
        } else {
            username.stringValue = "---"
        }

        nameOrUrl.stringValue = row?[login.name] ?? row?[login.url] ?? "---"
        password.stringValue = row?[login.password] ?? "---"

        let path = NSSearchPathForDirectoriesInDomains(
            .applicationSupportDirectory, .userDomainMask, true
            ).first! + "/"
        let str = "\(path)/\(row?[login.id] ?? 0).png"
        let image = NSImage(contentsOfFile: str)
        favicon.image = image
    }

    @IBAction func editButtonClicked(_ sender: NSButton) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let vc = storyboard.instantiateController(withIdentifier: "EditViewController") as! EditViewController
        vc.row = row

        let container = self.parent as! ContainerViewController

        for sView in container.containerView.subviews {
            sView.removeFromSuperview()
        }

        container.addChild(vc)
        vc.view.frame = container.containerView.bounds
        container.containerView.addSubview(vc.view)
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
