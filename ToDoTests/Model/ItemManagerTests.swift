//
//  ItemManagerTests.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-15.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
    var sut: ItemManager!
    
    override func setUp() {
        sut = ItemManager()
    }
    
    func test_toDoCount_IsInitiallyZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_isDoneCount_InitiallyZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_addItem_IncreasesCounter() {
        let curCounter = sut.toDoCount
        sut.add(ToDoItem(title: ""))
        
        XCTAssertEqual(sut.toDoCount, curCounter+1)
    }
    
    func test_itemAt_ChangesCount() {
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        
        XCTAssertEqual(sut.item(at:0).title, item.title)
    }
    
    func test_checkItemAt_ChangesCount() {
        sut.add(ToDoItem(title: ""))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_checkItemAt_RemovesFromList() {
        sut.add(ToDoItem(title: "First"))
        sut.add(ToDoItem(title: "Second"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).title, "Second")
    }
    
    func test_doneItem_ReturnsCheckedItem() {
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        sut.checkItem(at: 0)
        let returnItem = sut.doneItem(at:0)
        
        XCTAssertEqual(item.title, returnItem.title)
    }
}
