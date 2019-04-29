//
//  NSImageExtensions.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/20/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa

extension NSImage {
    func write(to url: URL, fileType: NSBitmapImageRep.FileType, options: Data.WritingOptions = .atomic) -> Bool {
        do {
            if let bits = representations.first as? NSBitmapImageRep {
                let data = bits.representation(using: fileType, properties: [:])
                try data?.write(to: url, options: options)
            }
            return true
        } catch {
            print(error)
            return false
        }
    }
}
