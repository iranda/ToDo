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
    
    /* To Do item */
    func test_Items_SetTitle() {
        let title = "Foo"
        let item = ToDoItem(title: title)
        XCTAssertEqual(item.title, title, "should set title")
        
    }
    
    func test_Items_SetDescription() {
        let description = "Bar"
        let item = ToDoItem(title: "Foo", description: description)
        XCTAssertEqual(item.description, description, "should set description")
    }
    
    func test_Items_SetTimestamp() {
        let timestamp: Double = Double(arc4random_uniform(24))
        let item = ToDoItem(title: "Foo", timestamp: timestamp)
        XCTAssertEqual(item.timestamp, timestamp, "should set timestamp")
    }
    
    func test_Items_TitlesAreEqual() {
        let item1 = ToDoItem(title: "Foo")
        let item2 = ToDoItem(title: "Foo")
        XCTAssertEqual(item1, item2)
    }
    
    func test_Items_TitlesAreNotEqual() {
        let item1 = ToDoItem(title: "First")
        let item2 = ToDoItem(title: "Second")
        XCTAssertNotEqual(item1, item2)
    }
    
    func test_Items_CompareDifferentTitles() {
        let item1 = ToDoItem(title: "First title", description: "Description")
        let item2 = ToDoItem(title: "Second title", description: "Description")
        XCTAssertNotEqual(item1, item2)
    }
    
    func test_Items_CompareDifferentDescriptions() {
        let item1 = ToDoItem(title: "Title", description: "First")
        let item2 = ToDoItem(title: "Title", description: "Second")
        XCTAssertNotEqual(item1, item2)
    }
    
    func test_Items_CompareDifferentTimestamp() {
        let item1 = ToDoItem(title: "", timestamp: 1.25)
        let item2 = ToDoItem(title: "", timestamp: 10.25)
        XCTAssertNotEqual(item1, item2)
    }
    
    /* Test Location */
    func test_Location_SetLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "Foo", location: location)
        XCTAssertEqual(item.location?.name, location.name, "should set location")
    }
    
    func test_Location_InitWithCoordinate() {
        let coordinate = CLLocationCoordinate2DMake(1, 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func test_Location_CompareDifferentLatitude() {
        performCompareTest (firstName: "Name", firstLongLat: (5,1),
                            secondName: "Name", secondLongLat: (1,1),
                            line: 66)
        
    }
    
    func test_Location_CompareDifferentLongtitude() {
        performCompareTest (firstName: "Name", firstLongLat: (1,5),
                            secondName: "Name", secondLongLat: (1,1),
                            line: 73)
    }
    
    func test_Location_CompareDifferentNames() {
        performCompareTest (firstName: "First name", firstLongLat: (1,1),
                            secondName: "Second name", secondLongLat: (1,1),
                            line: 79)
    }
    
    func performCompareTest(firstName: String,
                            firstLongLat: (Double, Double)?,
                            secondName: String,
                            secondLongLat: (Double, Double)?,
                            line: UInt) {
        var firstCoord: CLLocationCoordinate2D? = nil
        if let firstLongLat = firstLongLat {
            firstCoord = CLLocationCoordinate2D(latitude: firstLongLat.0,
                                                 longitude: firstLongLat.1)
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        var secondCoord: CLLocationCoordinate2D? = nil
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0,
                                                 longitude: secondLongLat.1)
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoord)

        XCTAssertNotEqual(firstLocation, secondLocation, line: line)
    }
}
