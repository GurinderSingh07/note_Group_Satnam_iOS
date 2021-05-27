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
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupInitials()
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
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
        
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.searchBar.searchTextField.textColor = UIColor.black
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Category"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = UIColor.black
    }
    
    //MARK:- UIButton
    @IBAction func tapCreateCategory(_ sender: UIBarButtonItem) {
        
        
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
}
