//
//  NSTableViewExtension.swift
//  allyourpasswords
//
//  File created by cognophile on 15/04/2019.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

extension NSTableView {
    open override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        let globalLocation = event.locationInWindow
        let localLocation = self.convert(globalLocation, to: nil)
        let selectedRow = self.row(at: localLocation)
        
        if (selectedRow != -1) {
            (self.delegate as? NSTableViewClickableDelegate)?.tableView(self, didClickRow: selectedRow)
        }
    }
}

protocol NSTableViewClickableDelegate: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, didClickRow selectedRow: Int)
}
