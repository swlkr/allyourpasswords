//
//  ContainerViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/18/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite

class ContainerViewController : NSViewController {

    var row : Row?
    var anyRows : Bool?
    var firstRow : Row?
    var detailViewController: DetailViewController?
    var emptyViewController: EmptyViewController?
    var editViewController: EditViewController?

    @IBOutlet weak var containerView: NSView!

    override func viewDidLoad() {
        let db = Database.open()
        let login = Login()
        let rowCount = try! db?.scalar(login.table.count)
        firstRow = try! db?.pluck(login.table.limit(0).order(login.name, login.url))

        if (rowCount! > 0) {
            row = firstRow
            showDetailViewController()
        } else {
            showEmptyViewController()
        }

        super.viewDidLoad()
    }

    func showDetailViewController() {
        if let oldViewController = detailViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            detailViewController = nil
        }

        if let oldViewController = editViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            editViewController = nil
        }

        if let oldViewController = emptyViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            emptyViewController = nil
        }

        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        detailViewController = storyboard.instantiateController(withIdentifier: "DetailViewController") as? DetailViewController
        detailViewController!.row = row ?? firstRow
        
        addChild(detailViewController!)
        detailViewController!.view.frame = containerView.bounds
        containerView.addSubview(detailViewController!.view)
    }

    func showEmptyViewController() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)

        if let oldViewController = emptyViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            emptyViewController = nil
        }

        if let oldViewController = detailViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            detailViewController = nil
        }

        if let oldViewController = editViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            editViewController = nil
        }

        emptyViewController = storyboard.instantiateController(withIdentifier: "EmptyViewController") as? EmptyViewController

        addChild(emptyViewController!)
        emptyViewController!.view.frame = containerView.bounds
        containerView.addSubview(emptyViewController!.view)
    }

    func showEditViewController() {
        if let oldViewController = editViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            editViewController = nil
        }

        if let oldViewController = detailViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            detailViewController = nil
        }

        if let oldViewController = emptyViewController {
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            emptyViewController = nil
        }

        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        editViewController = storyboard.instantiateController(withIdentifier: "EditViewController") as? EditViewController
        editViewController!.row = row
        editViewController!.anyRows = firstRow != nil

        addChild(editViewController!)
        editViewController!.view.frame = containerView.bounds
        containerView.addSubview(editViewController!.view)
    }

    @IBAction func addNewLogin(_ sender: NSMenuItem) {
        showEditViewController()
    }
}
