//
//  MouseTrackingTextView.swift
//  allyourpasswords
//
//  Created by Sean Walker on 2/2/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

class CursorChangingView: NSView {

    // MARK: - Lifecycle

    override func awakeFromNib() {
        setupTrackingArea()
    }

    // MARK: - Resizing

    // Call this in your controller's `viewDidLayout`
    // so it only gets called when the view resizes
    func superviewResized() {
        resetTrackingArea()
    }

    // MARK: - Mouse Events

    override func resetCursorRects() {
        addCursorRect(bounds, cursor: cursorType)
    }

    override func mouseMoved(with event: NSEvent) {
        cursorType.set()
    }

    // MARK: - Private Properties

    private var currentTrackingArea: NSTrackingArea?

    private var cursorType: NSCursor {
        return .pointingHand
    }

    // MARK: - Private API

    private func setupTrackingArea() {
        let trackingArea = NSTrackingArea(rect: bounds,
                                          options: [.activeAlways, .mouseMoved],
                                          owner: self, userInfo: nil)
        currentTrackingArea = trackingArea
        addTrackingArea(trackingArea)
    }

    private func resetTrackingArea() {
        if let trackingArea = currentTrackingArea {
            removeTrackingArea(trackingArea)
        }
        setupTrackingArea()
    }
}
