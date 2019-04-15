//
//  EmptyViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/19/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class EmptyViewController : NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addPasswordClicked(_ sender: NSButton) {
        let container = self.parent as! ContainerViewController
        container.row = nil
        container.isNew = true
        container.showEditViewController()
    }
    
}
