//
//  ToDoItemTests.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-14.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class ToDoItemTests: XCTestCase {
    
    func testSetTitle() {
        let title = "Foo"
        let item = ToDoItem(title: title)
        XCTAssertEqual(item.title, title, "should set title")
        
    }
    
    func testSetDescription() {
        let description = "Bar"
        let item = ToDoItem(title: "Foo", description: description)
        XCTAssertEqual(item.description, description, "should set description")
    }
    
    func testSetTimestamp() {
        let timestamp: Double = Double(arc4random_uniform(24))
        let item = ToDoItem(title: "Foo", timestamp: timestamp)
        XCTAssertEqual(item.timestamp, timestamp, "should set timestamp")
    }
    
    func testSetLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "Foo", location: location)
        XCTAssertEqual(item.location?.name, location.name, "should set location")
    }
    
    func testInitWithCoordinate() {
        let coordinate = CLLocationCoordinate2DMake(1, 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
}
