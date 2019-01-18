//
//  TableViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/18/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite

class TableViewController : NSViewController, NSTableViewDelegate, NSTableViewDataSource, NSSearchFieldDelegate {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var addButton: NSButton!

    var rows : [Row]? = []
    var filteredRows : [Row]? = []
    var row : Row? = nil
    var db : Connection? = nil
    let login = Login()
    var detailViewController : DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchField.delegate = self

        db = Database.open()
        rows = Array((try! db?.prepare(login.table))!)
        filteredRows = rows

        tableView.reloadData()
    }

    func controlTextDidChange(_ obj: Notification) {
        if obj.object as? NSSearchField == searchField {
            filterWithString(searchField.stringValue)
        }
    }

    func filterWithString(_ searchFieldValue: String) {
        if searchFieldValue.count > 0 {
            filteredRows = rows?.filter { r in
                return (r[login.name]?.lowercased().contains(searchFieldValue.lowercased()))! ||
                    (r[login.username]?.lowercased().contains(searchFieldValue.lowercased()))! ||
                    (r[login.email]?.lowercased().contains(searchFieldValue.lowercased()))!
            }
        } else {
            filteredRows = rows
        }

        if(filteredRows?.count == 1) {
            tableView.selectRowIndexes(NSIndexSet(index: 0) as IndexSet, byExtendingSelection: false)
        }

        tableView.reloadData()
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return filteredRows?.count ?? 0
    }

//    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
//        return 50
//    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CustomTableCellView"), owner: self) as? CustomTableCellView

        guard let item = filteredRows?[row] else {
            return nil
        }

        cell?.nameOrUrl.stringValue = item[login.name] ?? item[login.url] ?? ""
        cell?.emailOrUsername.stringValue = item[login.email] ?? item[login.username] ?? ""
        cell?.favicon.image = NSImage(named: "NSUser")

        return cell
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let rowIndex = tableView.selectedRow

        if rowIndex > -1, rowIndex < filteredRows?.count ?? 0, let row = filteredRows?[rowIndex] {
            detailViewController?.row = row
        }

    }
    
    @IBAction func addButtonClicked(_ sender: NSButton) {
    }
}
