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
    var tableView : NSTableView?

    @IBOutlet weak var containerView: NSView!

    override func viewWillAppear() {
        super.viewWillAppear()

//        let db = Database.open()
//        let login = Login()
//        let rowCount = try! db?.scalar(login.table.count)
//
//        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
//
//        for sView in containerView.subviews {
//            sView.removeFromSuperview()
//        }
//
//        if rowCount == 0 {
//            let vc = storyboard.instantiateController(withIdentifier: "EmptyViewController") as! EmptyViewController
//            addChild(vc)
//            vc.view.frame = containerView.bounds
//            containerView.addSubview(vc.view)
//        } else if row == nil {
//            let vc = storyboard.instantiateController(withIdentifier: "EditViewController") as! EditViewController
//            vc.tableView = tableView
//            addChild(vc)
//            vc.view.frame = containerView.bounds
//            containerView.addSubview(vc.view)
//        } else {
//            let vc = storyboard.instantiateController(withIdentifier: "DetailViewController") as! DetailViewController
//            vc.row = row
//            addChild(vc)
//            vc.view.frame = containerView.bounds
//            containerView.addSubview(vc.view)
//        }
    }

    func showDetailViewController() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)

        for sView in containerView.subviews {
            sView.removeFromSuperview()
        }

        let vc = storyboard.instantiateController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.row = row
        
        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
    }

    func showEmptyViewController() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)

        for sView in containerView.subviews {
            sView.removeFromSuperview()
        }

        let vc = storyboard.instantiateController(withIdentifier: "EmptyViewController") as! EmptyViewController

        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
    }

    func showEditViewController() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)

        for sView in containerView.subviews {
            sView.removeFromSuperview()
        }

        let vc = storyboard.instantiateController(withIdentifier: "EditViewController") as! EditViewController

        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
