//
//  NotesController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 27/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class NotesController: UIViewController {

     //MARK:- IBOutlets
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var optionButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIBarButtonItem!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupInitials()
    }

    //MARK:- PrivateMethods
    func setupInitials(){
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupView(){
        
        // Set navigation bar title
        self.title = "Note"
        
        // Set up navigation bar attributes properties.
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 20) ??
                UIFont.systemFont(ofSize: 20)]
    }
    
    //MARK:- UIButtons
    @IBAction func editFunction(_ sender: Any) {
        
    }
    
    @IBAction func optionButtonFunction(_ sender: Any) {
        
    }
    
    @IBAction func moveFunction(_ sender: Any) {
        
        
    }
    
    @IBAction func createNoteFunction(_ sender: Any) {
        
        
    }
    
    @IBAction func deleteFunction(_ sender: Any) {
        
    }
}

extension NotesController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.viewContainer.layer.cornerRadius = 5
        
        return cell
    }
}
