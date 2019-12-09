//
//  ViewController.swift
//  Flag Game
//
//  Created by Volkan Sahin on 30.10.2019.
//  Copyright © 2019 Volkan Sahin. All rights reserved.
//

import UIKit
// User Selection of Game Type
// There are two type of Games.
// First User have only one chance to find the correct answer.
// Second User have two chances to find the answer.

class ViewController: UITableViewController {
    //Decleration of variables.
    var gameTypes = ["1 Shot Challenge", "2 Shot Challenge"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Remove the seperator of tables.
        tableView.separatorStyle = .none
        
    }
    //Tableview row count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameTypes.count
    }
    //Tableview cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Games", for: indexPath)
        cell.textLabel?.text = gameTypes[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    //According to selection "name" variable will send to other viewcontroller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "GameScreen") as? GameScreenViewController{
            vc.name = gameTypes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
