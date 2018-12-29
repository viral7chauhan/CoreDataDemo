//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Falguni Viral Chauhan on 06/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var companies: [Company]?
    
    @IBOutlet weak var companiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Fetch data from database
        companies = CoreDataHandler.fetchData()
        companiesTableView.reloadData()
    }
    
    @IBAction func addClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "AlterData_Segue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let companies = companies {
            return companies.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let aCompany = companies![indexPath.row]
        cell.textLabel?.text = aCompany.name
        cell.detailTextLabel?.text = aCompany.ceo
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let aCompany = companies![indexPath.row]
            if CoreDataHandler.deleteData(company: aCompany ) {
                print("delete successfully")
                companies?.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aCompany = companies![indexPath.row]
        self.performSegue(withIdentifier: "AlterData_Segue", sender: aCompany)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlterData_Segue" {
            if sender != nil ,let c = sender as? Company {
                if let vc = segue.destination as? AddEditViewController {
                    vc.updateCompany = c
                }
            }
        }
        
    }
}

