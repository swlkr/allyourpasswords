//
//  CustomTextFieldCell.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class CustomTextFieldCell: NSTextFieldCell {

    private static let padding = CGSize(width: 4.0, height: 4.0)

    override func cellSize(forBounds rect: NSRect) -> NSSize {
        var size = super.cellSize(forBounds: rect)
        size.height += (CustomTextFieldCell.padding.height * 2)
        return size
    }

    override func titleRect(forBounds rect: NSRect) -> NSRect {
        return rect.insetBy(dx: CustomTextFieldCell.padding.width, dy: CustomTextFieldCell.padding.height)
    }

    override func edit(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, event: NSEvent?) {
        let insetRect = rect.insetBy(dx: CustomTextFieldCell.padding.width, dy: CustomTextFieldCell.padding.height)
        super.edit(withFrame: insetRect, in: controlView, editor: textObj, delegate: delegate, event: event)
    }

    override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        let insetRect = rect.insetBy(dx: CustomTextFieldCell.padding.width, dy: CustomTextFieldCell.padding.height)
        super.select(withFrame: insetRect, in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
    }

    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        let insetRect = cellFrame.insetBy(dx: CustomTextFieldCell.padding.width, dy: CustomTextFieldCell.padding.height)
        super.drawInterior(withFrame: insetRect, in: controlView)
    }

}

class CustomSecureTextFieldCell: NSSecureTextFieldCell {

    private static let padding = CGSize(width: 4.0, height: 8.0)

    override func cellSize(forBounds rect: NSRect) -> NSSize {
        var size = super.cellSize(forBounds: rect)
        size.height += (CustomSecureTextFieldCell.padding.height * 2)
        return size
    }

    override func titleRect(forBounds rect: NSRect) -> NSRect {
        return rect.insetBy(dx: CustomSecureTextFieldCell.padding.width, dy: CustomSecureTextFieldCell.padding.height)
    }

    override func edit(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, event: NSEvent?) {
        let insetRect = rect.insetBy(dx: CustomSecureTextFieldCell.padding.width, dy: CustomSecureTextFieldCell.padding.height)
        super.edit(withFrame: insetRect, in: controlView, editor: textObj, delegate: delegate, event: event)
    }

    override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        let insetRect = rect.insetBy(dx: CustomSecureTextFieldCell.padding.width, dy: CustomSecureTextFieldCell.padding.height)
        super.select(withFrame: insetRect, in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
    }

    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        let insetRect = cellFrame.insetBy(dx: CustomSecureTextFieldCell.padding.width, dy: CustomSecureTextFieldCell.padding.height)
        super.drawInterior(withFrame: insetRect, in: controlView)
    }

}
