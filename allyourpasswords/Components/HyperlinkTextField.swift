//
//  HyperlinkTextField.swift
//  allyourpasswords
//
//  Created by Sean Walker on 2/2/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

@IBDesignable
class HyperlinkTextField: NSTextField {
    @IBInspectable var href: String?

    override func awakeFromNib() {
        super.awakeFromNib()

        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: NSColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single
        ]
        self.attributedStringValue = NSAttributedString(string: self.stringValue, attributes: attributes)
    }

    override func mouseDown(with theEvent: NSEvent) {
        if !(self.href ?? "").isEmpty {
            NSWorkspace.shared.open(URL(string: self.href ?? "")!)
        }
    }
}
