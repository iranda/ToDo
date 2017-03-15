//
//  ItemManager.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-15.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import Foundation

struct ItemManager {
    var toDoCount = 0
    var doneCount = 0
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    mutating func add (_ item: ToDoItem) {
        self.toDoCount += 1
        self.toDoItems.append(item)
    }
    
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    mutating func checkItem(at index: Int) {
        self.toDoCount -= 1
        self.doneCount += 1
        self.doneItems.append(self.toDoItems.remove(at: index))
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return self.doneItems[index]
    }
    
    
}
