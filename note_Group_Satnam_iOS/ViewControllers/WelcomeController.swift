//
//  WelcomeController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 27/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tbCategories: UITableView!
    
    //MARK:- MemberVariables
    let searchController = UISearchController(searchResultsController: nil)
    
    private var folders = [Folder]()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupInitials()
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
        // Set navigation bar title
        self.title = "Categories"
        
        // Set up navigation bar attributes properties.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 40) ??
                UIFont.systemFont(ofSize: 40)]
        
        showSearchBar()
    }
    
    func showSearchBar() {
        
        // Set search bar textfield attributes.
        searchController.searchBar.placeholder = "Search Category"
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.searchBar.searchTextField.textColor = UIColor.black
        
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //MARK:- UIButton
    @IBAction func tapCreateCategory(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Create Category", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {field in field.placeholder = "Category Name"})
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {
            _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension WelcomeController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.viewContainer.layer.cornerRadius = 5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               let alert = UIAlertController(title: "Are you sure?", message: "Delete note", preferredStyle: .actionSheet)
               let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                  
               })
               let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
               alert.addAction(deleteButton)
               alert.addAction(cancelButton)
               self.present(alert, animated: true, completion: nil)
           }
       }
}
