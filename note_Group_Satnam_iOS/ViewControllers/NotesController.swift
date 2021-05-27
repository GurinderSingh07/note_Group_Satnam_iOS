//
//  NotesController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 27/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class NotesController: UIViewController {

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
