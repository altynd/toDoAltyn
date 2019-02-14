//
//  ViewController.swift
//  toDoAltyn
//
//  Created by Altyn Dmitry on 09/02/2019.
//  Copyright © 2019 Altyn Dmitry. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var itemArray = [Item]()
 
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
 
    }
    // сколько строк будет в таблице
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let  item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
//        тоже самое что строчка выше
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        } else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    // выбор строки таблвью
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //проверка на галочку, если стоит то убрать
        
        let item = itemArray[indexPath.row]
        
        item.done = !item.done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Item", message: "massege", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // что случится когда нажимаем кнопку +
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion:  nil)
    }
    
    func saveItems (){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath! )
        } catch{
            print("Eror incoding item array \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Erroro decoding item array, \(error)")
            }
        }
    }
}

