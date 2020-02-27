//
//  ViewController.swift
//  GroceryList
//
//  Created by Jokela, Benjamin on 2020-02-27.
//  Copyright © 2020 Jokela, Benjamin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBAction func saveButton(_ sender: UIButton) {
    }
    
    
    @IBAction func refreshButton(_ sender: UIButton) {
    }
    
    var items : [Item] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

