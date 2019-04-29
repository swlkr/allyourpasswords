//
//  Database.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/17/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import SQLite

public struct Database {
    static func open() -> Connection {
        let path = NSSearchPathForDirectoriesInDomains(
            .applicationSupportDirectory, .userDomainMask, true
            ).first! + "/" + Bundle.main.bundleIdentifier!

        try! FileManager.default.createDirectory(
            atPath: path, withIntermediateDirectories: true, attributes: nil
        )

        let masterPassword = KeychainWrapper.standard.string(forKey: "MasterPassword")

        let conn = try! Connection("\(path)/encrypted.sqlite3")
        try! conn.key(masterPassword!)

        #if DEBUG
        conn.trace { print($0) }
        #endif

        return conn
    }
}
