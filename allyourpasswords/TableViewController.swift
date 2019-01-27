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
    var containerViewController : ContainerViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)

        tableView.delegate = self
        tableView.dataSource = self
        searchField.delegate = self

        db = Database.open()

        reloadTableView()
    }

    @objc func reloadTableView() {
        let query = login.table.order(login.name, login.url)
        rows = Array((try! db?.prepare(query))!)
        filteredRows = rows
        tableView.reloadData()

        if (filteredRows?.count)! > 0 {
            tableView.selectRowIndexes(NSIndexSet(index: 0) as IndexSet, byExtendingSelection: false)
            containerViewController?.row = rows?[0]
            containerViewController?.showDetailViewController()
        } else {
            containerViewController?.showEmptyViewController()
        }
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

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CustomTableCellView"), owner: self) as? CustomTableCellView

        guard let item = filteredRows?[row] else {
            return nil
        }

        cell?.nameOrUrl.stringValue = item[login.name] ?? item[login.url] ?? ""
        cell?.emailOrUsername.stringValue = item[login.email] ?? item[login.username] ?? ""
        let path = NSSearchPathForDirectoriesInDomains(
            .applicationSupportDirectory, .userDomainMask, true
            ).first! + "/"
        let url = URL(string: item[login.url]!)
        let domain = url?.host
        let str = "\(path)/\(domain ?? "").png"
        let image = NSImage(contentsOfFile: str)
        cell?.favicon.image = image

        return cell
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let rowIndex = tableView.selectedRow

        if rowIndex > -1, rowIndex < filteredRows?.count ?? 0 {
            self.row = filteredRows?[rowIndex]
            containerViewController?.row = self.row
            containerViewController?.showDetailViewController()
        }
    }

    @IBAction func addButtonClicked(_ sender: NSButton) {
        containerViewController?.row = nil
        containerViewController?.anyRows = filteredRows?.count ?? 0 > 0
        containerViewController?.showEditViewController()
    }

    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
    }

    @IBAction func deleteLogin(_ sender: NSMenuItem) {
        let indices = tableView.selectedRowIndexes
        let ids = indices.compactMap { (filteredRows?.count ?? -1 > $0) ? filteredRows?[$0][login.id] : nil}
        let answer = dialogOKCancel(question: "Are you sure you want to delete \(ids.count) login(s)?", text: "")

        if answer == true {
            do {
                let lg = login.table.filter(ids.contains(login.id))
                if try db?.run(lg.delete()) ?? 0 > 0 {
                    reloadTableView()
                } else {
                    print("login not found")
                }
            } catch {
                print("delete failed: \(error)")
            }
        }
    }

    func copyToPasteBoard(_ string: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(string, forType: .string)
    }

    @IBAction func copy(_ sender: NSMenuItem) {
        copyToPasteBoard(row?[login.password] ?? "")
    }

    @IBAction func copyEmailOrUsername(_ sender: NSMenuItem) {
        if row?[login.email] != nil && row?[login.email] != "" {
            copyToPasteBoard(row?[login.email] ?? "")
        } else {
            copyToPasteBoard(row?[login.username] ?? "")
        }
    }
}
