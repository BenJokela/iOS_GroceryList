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
        saveItem()
        
    }
    
    var items : [Item] = []
    
    func saveItem(){
        let context = appDelegate.persistentContainer.viewContext
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context)
        
        if let item = itemTextField.text{
            if item != "" {
                newItem.setValue(item, forKey: "itemName")
            }else{
                let alert = UIAlertController(title: "Error", message: "Item name cannot be empty", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert, animated: true)
            }
        }
        do{
            try context.save()
            refreshTableView()
        }catch{
            let alert = UIAlertController(title: "Error", message: "Oops, something went wrong", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)
            
        }
        
    }
    
    func refreshTableView(){
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        var results : [AnyObject]?
        do{
            results = try context.fetch(request)
        }catch{
            results = nil
        }
        
        if results != nil {
            self.items = results as! [Item]
        }
        self.tableView.reloadData()
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let item = result.value(forKey: "itemName") as? String {
                        let alert = UIAlertController(title: "Woo", message: "\(itemTextField.text!) added!", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                        self.present(alert, animated: true)
                        
                    }
                }
            }else{
                let alert = UIAlertController(title: "", message: "No results", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert, animated: true)
                
            }
        }catch{
            let alert = UIAlertController(title: "Error", message: "Could not fetch - error...", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let item = self.items[indexPath.row]
        var itemName = ""
        
        if item.itemName != nil {
            itemName = item.itemName!
            
            if itemName != ""{
                cell.contentLabel!.text = itemName
            }else{
                let alert = UIAlertController(title: "Error", message: "Item name cannot be empty", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert, animated: true)            }
        }else{
            let alert = UIAlertController(title: "Error", message: "Item name cannot be nil", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(items[indexPath.row])
        appDelegate.saveContext()
        
        items.remove(at: indexPath.row)
        
        let alert = UIAlertController(title: "Success", message: "Selected item removed!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        refreshTableView()
    }


}

