//
//  ItemsListViewController.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-22.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import UIKit

class ItemsListViewController: UIViewController {
//    var tableView: UITableView?
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView = UITableView()
        tableView?.dataSource = dataProvider
        tableView?.delegate = dataProvider
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
