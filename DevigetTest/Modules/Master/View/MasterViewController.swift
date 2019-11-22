//
//  MasterViewController.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet var dismissAllbutton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var presenter: MasterPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.registerInputs(table: tableView, dismissAllButton: dismissAllbutton)
    }
    
    @IBAction func dismissAllButtonTapped(_ sender: UIButton) {
        
    }
}
