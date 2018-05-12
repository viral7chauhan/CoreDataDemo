//
//  AddViewController.swift
//  CoreDataDemo
//
//  Created by Falguni Viral Chauhan on 06/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ceoText: UITextField!
    var updateCompany: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if updateCompany == nil {
            title = "Add"
        } else {
            title = "Update"
            nameText.text = updateCompany?.name
            ceoText.text = updateCompany?.ceo
        }
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func doneClicked() {
        if updateCompany == nil {
            saveNewDataToDb()
        } else {
            updateDataToDb()
        }
        navigationController?.popViewController(animated: true)
    }
    
    func saveNewDataToDb() {
        guard let name = nameText.text, let ceo = ceoText.text else { return }
        if CoreDataHandler.saveData(name: name, ceo: ceo) {
            print("data save successfully")
        }
    }
    
    func updateDataToDb(){
        if let company = updateCompany {
            guard let name = nameText.text, let ceo = ceoText.text else { return }
            if CoreDataHandler.updateData(aCompany: company, newName: name, newCeo: ceo) {
                print("update successfully")
            }
        }
    }


}
