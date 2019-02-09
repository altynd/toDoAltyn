//
//  ViewController.swift
//  toDoAltyn
//
//  Created by Altyn Dmitry on 09/02/2019.
//  Copyright © 2019 Altyn Dmitry. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    let itemArray = ["Сделай это","Потом сделай это","Потом сделай то"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
// сколько строк будет в таблице
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }
    
// выбор строки таблвью
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //проверка на галочку, если стоит то убрать
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else{
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

