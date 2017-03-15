//
//  ToDoItem.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-14.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import Foundation

struct ToDoItem {
    let title: String
    let description: String?
    let timestamp: Double?
    let location: Location?
    
    init (title: String, description: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        self.timestamp = timestamp
        self.location = location
    }
}
