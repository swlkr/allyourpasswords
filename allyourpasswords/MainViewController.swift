//
//  MainViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class MainViewController : NSSplitViewController {
    @IBOutlet weak var leftSplit: NSSplitViewItem!
    @IBOutlet weak var rightSplit: NSSplitViewItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        let containerViewController = rightSplit.viewController as? ContainerViewController
        let tableViewController = leftSplit.viewController as? TableViewController

        tableViewController?.containerViewController = containerViewController
        containerViewController?.tableViewController = tableViewController
    }
}
