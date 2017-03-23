//
//  ItemListDataProviderTests.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-22.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
    var sut: ItemListDataProvider?
    var tableView: UITableView?
    
    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        tableView = UITableView()
        tableView?.dataSource = sut
    }
    
    func test_numberOfSectionsIsTwo() {
        XCTAssertEqual(tableView?.numberOfSections, 2)
    }
    
    func test_numberOfRowsInFirstSection_IsToDoCount() {
        sut?.itemManager = ItemManager()
        
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        XCTAssertEqual(tableView?.numberOfRows(inSection: 0), 1)
        sut?.itemManager?.add(ToDoItem(title: "Foo1"))
        tableView?.reloadData() 
        XCTAssertEqual(tableView?.numberOfRows(inSection: 0), 2)
    }
    
    func test_numberOfRowsInFirstSection_IsDoneCount() {
        sut?.itemManager = ItemManager()
        
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        sut?.itemManager?.add(ToDoItem(title: "Foo1"))
        
        sut?.itemManager?.checkItem(at: 0)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 1), 1)
        
        sut?.itemManager?.checkItem(at: 0)
        tableView?.reloadData()
        XCTAssertEqual(tableView?.numberOfRows(inSection: 1), 2)
    }
    
    func test_cellForRow_ReturnsItemCell() {
        sut?.itemManager = ItemManager()
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        tableView?.reloadData()
        
        let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ItemCell)
    }
}
