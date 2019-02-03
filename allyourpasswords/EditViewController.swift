//
//  EditViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/18/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite
import FavIcon

class EditViewController : NSViewController {

    var row : Row?
    var isNew : Bool?
    let login = Login()
    var db : Connection?

    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSTextField!
    @IBOutlet weak var websiteTextField: NSTextField!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var passwordLengthLabel: NSTextField!
    @IBOutlet weak var numberButton: NSButton!
    @IBOutlet weak var symbolButton: NSButton!
    @IBOutlet weak var passwordLengthSlider: NSSlider!
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var faviconImageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.window?.defaultButtonCell = saveButton.cell as? NSButtonCell

        websiteTextField.becomeFirstResponder()

        if isNew == true {
            passwordTextField.stringValue = randomString(passwordLengthSlider.integerValue)
            passwordLengthLabel.stringValue = "\(passwordTextField.stringValue.count)"
        } else {
            emailTextField.stringValue = row?[login.email] ?? ""
            usernameTextField.stringValue = row?[login.username] ?? ""
            passwordTextField.stringValue = row?[login.password] ?? ""
            websiteTextField.stringValue = row?[login.url] ?? ""
            nameTextField.stringValue = row?[login.name] ?? ""
            passwordLengthLabel.stringValue = "\(passwordTextField.stringValue.count)"
            let path = NSSearchPathForDirectoriesInDomains(
                .applicationSupportDirectory, .userDomainMask, true
                ).first! + "/"  + Bundle.main.bundleIdentifier!
            let url = URL(string: row?[login.url] ?? "")
            let domain = url?.host
            let str = "\(path)/\(domain ?? "").png"
            let image = NSImage(contentsOfFile: str)
            faviconImageView.image = image
        }
    }
    @IBAction func websiteDidEndEditing(_ sender: NSTextField) {
        let urlString = sender.stringValue
        let url = URL(string: urlString)
        let domain = url?.host
        if nameTextField.stringValue.isEmpty {
            nameTextField.stringValue = domain ?? ""
        }

        do {
            try FavIcon.downloadPreferred(url!, width: 152, height: 152) { result in
                if case let .success(image) = result {
                    let path = NSSearchPathForDirectoriesInDomains(
                        .applicationSupportDirectory, .userDomainMask, true
                        ).first! + "/" + Bundle.main.bundleIdentifier!
                    let url = NSURL(fileURLWithPath: "\(path)/\(domain!).png").filePathURL!
                    image.write(to: url, fileType: .png)
                }
            }
        } catch {
            print("Error: \(error)")

        }
    }

    func saveLogin() {
        if emailTextField.stringValue.isEmpty &&
            usernameTextField.stringValue.isEmpty &&
            nameTextField.stringValue.isEmpty &&
            websiteTextField.stringValue.isEmpty {
            return
        }

        if isNew == true {
            let insert = login.table.insert(
                login.email <- emailTextField.stringValue,
                login.username <- usernameTextField.stringValue,
                login.password <- passwordTextField.stringValue,
                login.name <- nameTextField.stringValue,
                login.url <- websiteTextField.stringValue)

            try! db?.run(insert)

            let query = login.table.order(login.id.desc).limit(1)

            row = try! db?.pluck(query)
        } else {
            let editRow = login.table.filter(login.id == row?[login.id] ?? -1)

            let update = editRow.update(
                login.email <- emailTextField.stringValue,
                login.username <- usernameTextField.stringValue,
                login.password <- passwordTextField.stringValue,
                login.name <- nameTextField.stringValue,
                login.url <- websiteTextField.stringValue)

            try! db?.run(update)

            row = try! db?.pluck(login.table.filter(login.id == row?[login.id] ?? -1))
        }

        let container = self.parent as! ContainerViewController
        container.row = self.row
        container.showDetailViewController()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
    }

    @IBAction func saveLogin(_ sender: NSMenuItem) {
        saveLogin()
    }

    @IBAction func saveButtonClicked(_ sender: NSButton) {
        saveLogin()
    }

    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        let container = self.parent as! ContainerViewController
        let rowCount = try! db?.scalar(login.table.count)

        if rowCount ?? 0 > 0 {
            container.row = self.row
            container.showDetailViewController()
        } else {
            container.showEmptyViewController()
        }
    }

    func randomString(_ length: Int) -> String {
        var numberValues = ""
        if numberButton.state == .on {
            numberValues = "123456790"
        }

        var symbolValues = ""
        if symbolButton.state == .on {
            symbolValues = "!@#$%^&*()-_"
        }

        let values = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\(numberValues)\(symbolValues)"
        return String((0...length-1).map{ _ in values.randomElement()! })
    }

    @IBAction func sliderChanged(_ sender: NSSlider) {
        let passwordLength = sender.integerValue
        let password = randomString(passwordLength)
        passwordLengthLabel.stringValue = "\(passwordLength)"
        passwordTextField.stringValue = password
    }
}
