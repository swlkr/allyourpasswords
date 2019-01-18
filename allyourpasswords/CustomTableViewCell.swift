//
//  CustomTableViewCell.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class CustomTableCellView : NSTableCellView {
    @IBOutlet weak var nameOrUrl: NSTextField!
    @IBOutlet weak var emailOrUsername: NSTextField!
    @IBOutlet weak var favicon: NSImageView!
}
