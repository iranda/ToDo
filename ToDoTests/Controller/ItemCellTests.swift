//
//  ItemCellTests.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-25.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemsListViewController")
            as! ItemsListViewController
        _ = controller.view
        
        tableView = controller.tableView
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell",
                                                  for: IndexPath(row: 0, section: 0)) as! ItemCell
    }
    
    func test_hasNameLabel(){
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func test_hasLocationLabel(){
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func test_hasDateLabel(){
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func test_configCell_SetsLabelTexts() {
        cell.configCell(with: ToDoItem(title: "Foo",
                                       description: nil,
                                       timestamp: 1456150025,
                                       location: Location(name: "Bar")))
        
        XCTAssertEqual(cell.titleLabel.text, "Foo")
        XCTAssertEqual(cell.locationLabel.text, "Bar")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
    func test_configCell_WhenItemIsChecked_IsStrokeThrough() {
        let item = ToDoItem(title: "Foo",
                            description: nil,
                            timestamp: 1456150025,
                            location: Location(name: "Bar"))
        
        cell.configCell(with: item, checked: true)
        
        let attributedString = NSAttributedString(string: "Foo",
                                                  attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1;
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
