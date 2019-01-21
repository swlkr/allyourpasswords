//
//  EditViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/18/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite

class EditViewController : NSViewController {

    var row : Row?
    let login = Login()
    var tableViewController : TableViewController?

    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSTextField!
    @IBOutlet weak var websiteTextField: NSTextField!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var passwordLengthLabel: NSTextField!
    @IBOutlet weak var numberButton: NSButton!
    @IBOutlet weak var symbolButton: NSButton!
    @IBOutlet weak var passwordLengthSlider: NSSlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.stringValue = row?[login.email] ?? ""
        usernameTextField.stringValue = row?[login.username] ?? ""
        passwordTextField.stringValue = row?[login.password] ?? ""
        websiteTextField.stringValue = row?[login.url] ?? ""
        nameTextField.stringValue = row?[login.name] ?? ""

        if row != nil {
            passwordLengthLabel.stringValue = "\(passwordTextField.stringValue.count)"
        } else {
            passwordTextField.stringValue = randomString(passwordLengthSlider.integerValue)
            passwordLengthLabel.stringValue = "\(passwordTextField.stringValue.count)"
        }
    }
    @IBAction func websiteDidEndEditing(_ sender: NSTextField) {
        let urlString = sender.stringValue
        let url = URL(string: urlString)
        let domain = url?.host
        nameTextField.stringValue = domain ?? ""
    }

    @IBAction func saveButtonClicked(_ sender: NSButton) {
        let db = Database.open()

        if row == nil {
            let insert = login.table.insert(
                            login.email <- emailTextField.stringValue,
                            login.username <- usernameTextField.stringValue,
                            login.password <- passwordTextField.stringValue,
                            login.name <- nameTextField.stringValue,
                            login.url <- websiteTextField.stringValue)

            try! db?.run(insert)

            let query = login.table.order(login.id.desc)

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

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)

        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let vc = storyboard.instantiateController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.row = row

        let container = self.parent as! ContainerViewController

        for sView in container.containerView.subviews {
            sView.removeFromSuperview()
        }

        container.addChild(vc)
        vc.view.frame = container.containerView.bounds
        container.containerView?.addSubview(vc.view)
    }

    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let db = Database.open()
        let rows = try! db?.scalar(login.table.count) ?? 0
        if rows > 0 {
            let vc = storyboard.instantiateController(withIdentifier: "DetailViewController") as! DetailViewController
            vc.row = row
            vc.tableViewController = tableViewController

            let container = self.parent as! ContainerViewController

            for sView in container.containerView.subviews {
                sView.removeFromSuperview()
            }

            container.addChild(vc)
            vc.view.frame = container.containerView.bounds
            container.containerView.addSubview(vc.view)
        } else {
            let vc = storyboard.instantiateController(withIdentifier: "EmptyViewController") as! EmptyViewController
            vc.tableViewController = tableViewController

            let container = self.parent as! ContainerViewController

            for sView in container.containerView.subviews {
                sView.removeFromSuperview()
            }

            container.addChild(vc)
            vc.view.frame = container.containerView.bounds
            container.containerView.addSubview(vc.view)
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
