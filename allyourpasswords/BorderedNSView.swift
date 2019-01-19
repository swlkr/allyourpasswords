//
//  BorderedNSView.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/19/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

extension NSView {
    @discardableResult func addRightBorder(color: NSColor, width: CGFloat) -> NSView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: self.frame.size.width-width, y: 0, width: width, height: self.frame.size.height)
        self.layer?.addSublayer(layer)
        return self
    }
    @discardableResult func addLeftBorder(color: NSColor, width: CGFloat) -> NSView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer?.addSublayer(layer)
        return self
    }
    @discardableResult func addTopBorder(color: NSColor, width: CGFloat) -> NSView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer?.addSublayer(layer)
        return self
    }
    @discardableResult func addBottomBorder(color: NSColor, width: CGFloat) -> NSView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: width)
        self.layer?.addSublayer(layer)
        return self
    }
}
