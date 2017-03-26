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
    var controller: ItemsListViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        sut?.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(
            withIdentifier: "ItemsListViewController") as! ItemsListViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView?.dataSource = sut
        tableView?.delegate = sut
    }
    
    func test_numberOfSectionsIsTwo() {
        XCTAssertEqual(tableView?.numberOfSections, 2)
    }
    
    func test_numberOfRowsInFirstSection_IsToDoCount() {
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        XCTAssertEqual(tableView?.numberOfRows(inSection: 0), 1)
        sut?.itemManager?.add(ToDoItem(title: "Foo1"))
        tableView?.reloadData() 
        XCTAssertEqual(tableView?.numberOfRows(inSection: 0), 2)
    }
    
    func test_numberOfRowsInFirstSection_IsDoneCount() {
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        sut?.itemManager?.add(ToDoItem(title: "Foo1"))
        
        sut?.itemManager?.checkItem(at: 0)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 1), 1)
        
        sut?.itemManager?.checkItem(at: 0)
        tableView?.reloadData()
        XCTAssertEqual(tableView?.numberOfRows(inSection: 1), 2)
    }
    
    func test_cellForRow_ReturnsItemCell() {
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        tableView?.reloadData()
        
        tableView?.register(ItemCell.self,
                            forCellReuseIdentifier: "ItemCell")
        let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ItemCell)
    }
    
    func test_cellForRow() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut!)
        
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func test_CellForRow_CallsConfigCell() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut!)
        
        let item = ToDoItem(title: "Foo")
        sut?.itemManager?.add(item)
        mockTableView.reloadData()
        
        
        let cell = mockTableView
            .cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.catchedItem, item)
    }
    
    func test_CellForRow_InSectionTwo_CallsConfigCellWithDoneItem() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut!)
        
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        let item = ToDoItem(title: "Bar")
        sut?.itemManager?.add(item)
        sut?.itemManager?.checkItem(at: 1)
        mockTableView.reloadData()
        
        let cell = mockTableView
            .cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        
        
        XCTAssertEqual(cell.catchedItem, item)
    }
    
    func test_DeleteButton_InFirstSection_ShowsTitleCheck() {
        let deleteButtonTitle = tableView?.delegate?.tableView?( tableView!,
                                                                 titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0,
                                                                 section: 0))
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func test_DeleteButton_InSecondSection_ShowsTitleUncheck() {
        let deleteButtonTitle = tableView?.delegate?.tableView?(tableView!,
                                                               titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0,
                                                                                                                   section: 1))
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }
    
    func test_CheckingItem_ChecksItInTheItemManager() {
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        tableView?.dataSource?.tableView?(tableView!,
                                          commit: .delete,
                                          forRowAt: IndexPath(row: 0, section:0) )
        
        XCTAssertEqual(sut?.itemManager?.getItemsCount().toDoCount, 0)
        XCTAssertEqual(sut?.itemManager?.getItemsCount().doneCount, 1)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 1), 1)
    }
    
    func test_UncheckingItem_UnchecksItInTheItemManager() {
        sut?.itemManager?.add(ToDoItem(title: "Foo"))
        sut?.itemManager?.checkItem(at: 0)
        tableView?.reloadData()
        tableView?.dataSource?.tableView?(tableView!,
                                          commit: .delete,
                                          forRowAt: IndexPath(row: 0, section:1) )
        
        XCTAssertEqual(sut?.itemManager?.getItemsCount().toDoCount, 1)
        XCTAssertEqual(sut?.itemManager?.getItemsCount().doneCount, 0)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 1), 0)
    }
}

extension ItemListDataProviderTests {
    
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480),
                                              style: .plain)
        
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            
            return mockTableView
        }
        
        override func dequeueReusableCell(
            withIdentifier identifier: String,
            for indexPath: IndexPath) -> UITableViewCell {
            
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier,
                                             for: indexPath) 
        }
    }
    
    class MockItemCell : ItemCell {
        var catchedItem: ToDoItem?
        
        
        override func configCell(with item: ToDoItem) {
            catchedItem = item
        } 
    } 
}
