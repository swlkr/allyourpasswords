//
//  ToolbarCustomView.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/19/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class ToolbarCustomView: NSView {

    var gradient:NSGradient! = nil

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.wantsLayer = true
        self.needsDisplay = true;
        self.layer?.masksToBounds = true

        let startingColor:NSColor = NSColor(red: 244/256, green: 244/256, blue: 244/256, alpha: 1.0)
        let endingColor:NSColor = NSColor(red: 203/256, green: 203/256, blue: 203/256, alpha: 1.0)

        gradient = NSGradient(starting: startingColor, ending: endingColor)!;

        if self.window?.isKeyWindow == true  {
            gradient.draw(in: self.bounds, angle:  270 )
        }else{
            self.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        }

        //The bottom border
        self.layer?.borderColor = NSColor(red: 160/256, green: 160/256, blue: 160/256, alpha: 1).cgColor;


        //Recieve window key status notification and force redraw of the custom toolbar to update the background
//        NotificationCenter.default.setObserver(self, selector: #selector(ToolbarCustomView.handleParentWindowStateChange(_:)) , name: NSNotification.Name.NSWindowDidBecomeKey.rawValue, object: self.window)
//        NotificationCenter.default.setObserver(self, selector: #selector(ToolbarCustomView.handleParentWindowStateChange(_:)) , name: NSNotification.Name.NSWindowDidResignKey.rawValue, object: self.window)

    }



    func handleParentWindowStateChange(_ notification:Notification) {

        //The background
        //self.needsDisplay = true;
        //self.needsLayout = true

    }

}
