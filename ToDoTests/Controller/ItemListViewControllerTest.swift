//
//  ItemListViewControllerTest.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-22.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTest: XCTestCase {
    var sut: ItemsListViewController?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "ItemsListViewController")
        sut = viewController as? ItemsListViewController
    }
    
    func test_tableView_AfterViewDidLoad_IsNotNil() {
        _ = sut?.view
        
        XCTAssertNotNil(sut?.tableView) 
    }
    
    func test_loadingView_SetsTableViewDataSource() {
        _ = sut?.view
        
        XCTAssertTrue(sut?.tableView?.dataSource is ItemListDataProvider)
    }
    
    func test_loadingView_SetsTableViewDelegate() {
        _ = sut?.view
        
        XCTAssertTrue(sut?.tableView?.delegate is ItemListDataProvider)
    }
    
    func test_loadingView_SetsDataSourceAndDelegateToSameObject() {
        _ = sut?.view
        
        XCTAssertEqual(sut?.tableView?.dataSource as? ItemListDataProvider,
                       sut?.tableView?.delegate as? ItemListDataProvider)
    }
}
