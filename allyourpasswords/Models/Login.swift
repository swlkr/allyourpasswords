//
//  Login.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/18/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import SQLite

public struct Login {
    let table = Table("login")
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let url = Expression<String?>("url")
    let username = Expression<String?>("username")
    let email = Expression<String?>("email")
    let password = Expression<String?>("password")

    init() {}
}
