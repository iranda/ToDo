//
//  ItemManager.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-15.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import Foundation

struct ItemManager {
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    func getItemsCount() -> (toDoCount: Int, doneCount: Int) {
        return (toDoItems.count, doneItems.count)
    }
    
    mutating func add (_ item: ToDoItem) {
        self.toDoItems.append(item)
    }
    
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    mutating func checkItem(at index: Int) {
        self.doneItems.append(self.toDoItems.remove(at: index))
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return self.doneItems[index]
    }
    
    mutating func removeAll() {
        self.toDoItems.removeAll()
        self.doneItems.removeAll()
    }
    
}
