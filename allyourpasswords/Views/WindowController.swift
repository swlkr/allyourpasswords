//
//  WindowController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 2/23/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class WindowController : NSWindowController {
    override func windowDidLoad() {
        shouldCascadeWindows = false
        window?.setFrameAutosaveName("MainWindow")

        super.windowDidLoad()
    }
}
