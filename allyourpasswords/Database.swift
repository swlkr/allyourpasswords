//
//  Database.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import SQLite

public struct Database {
    static func open() -> Connection? {
        let path = NSSearchPathForDirectoriesInDomains(
            .applicationSupportDirectory, .userDomainMask, true
            ).first! + "/"

        do {
            try FileManager.default.createDirectory(
                atPath: path, withIntermediateDirectories: true, attributes: nil
            )
        } catch {
            #if DEBUG
            print("Unexpected error: \(error).")
            #endif
        }

        var conn : Connection?
        do {
            conn = try Connection("\(path)/app.db")
            if let masterPassword = KeychainWrapper.standard.string(forKey: "MasterPassword") {
                try conn?.key(masterPassword)
            }

            #if DEBUG
            conn?.trace { print($0) }
            #endif
        } catch {
            #if DEBUG
            print("Unexpected error: \(error).")
            #endif
        }

        return conn
    }
}
