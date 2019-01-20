//
//  EmptyViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/19/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class EmptyViewController : NSViewController {

    var tableViewController : TableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addPasswordClicked(_ sender: NSButton) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let container = self.parent as! ContainerViewController

        for sView in container.containerView.subviews {
            sView.removeFromSuperview()
        }

        container.tableViewController = tableViewController

        let vc = storyboard.instantiateController(withIdentifier: "EditViewController") as! EditViewController
        vc.tableViewController = tableViewController

        container.addChild(vc)
        vc.view.frame = container.containerView.bounds
        container.containerView.addSubview(vc.view)
    }
    
}
