//
//  WelcomeController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 27/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit
import CoreData

class WelcomeController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tbCategories: UITableView!
    @IBOutlet weak var createCategoryButton: UIBarButtonItem!
    
    //MARK:- MemberVariables
    let searchController = UISearchController(searchResultsController: nil)
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var folders = [Folder]()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitials()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
        showSearchBar()
        loadFolders()
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
    
    func setupView(){
        
        // Set navigation bar title
        self.title = "Categories"
        
        // Set up navigation bar attributes properties.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 40) ??
                UIFont.systemFont(ofSize: 40)]
    }
    
    private func loadFolders(predicate : NSPredicate? = nil)  {
        let request : NSFetchRequest<Folder> = Folder.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        if predicate != nil {
            request.predicate = predicate
        }
        do {
            self.folders = try self.context.fetch(request)
        } catch  {
            print(error)
        }
    }
    
    private func createFolder(name:String){
        let newFolder = Folder(context: context)
        folders.append(newFolder)
        newFolder.name = name
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    private func deleteFolder(folder:Folder){
        do{
            context.delete(folder)
            try context.save()
        }catch{
            print(error)
        }
    }
    
    //MARK:- UIButton
    @IBAction func createCategoryFunction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Create Category", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {field in field.placeholder = "Category Name"})
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {
            _ in
            
            //following is to get name of categories in lower case
            let categoryNames = self.folders.map{$0.name?.lowercased()}
            guard let text = alert.textFields?.first?.text else{return}
            print(text)
            guard !categoryNames.contains(text) else {
                let alertMessage = UIAlertController(title: "Folder already exist", message: "", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                return
            }
            self.createFolder(name: text)
            self.loadFolders()
            self.tbCategories.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension WelcomeController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        // Set View Container corner radius
        cell.viewContainer.layer.cornerRadius = 5
        
        cell.lblTitle.text = "\(folders[indexPath.row].name ?? "")"
        cell.lblSubtitle.text = "\(folders[indexPath.row].notes?.count ?? 0) - notes"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "", message: "Are you sure you want to delete note?", preferredStyle: .actionSheet)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.deleteFolder(folder: self.folders[indexPath.row])
                self.folders.remove(at: indexPath.row)
                self.tbCategories.reloadData()
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(deleteButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.title = ""
        
        let destinationView = self.storyboard?.instantiateViewController(identifier: "NotesView") as! NotesController
        
        destinationView.parentFolder = folders[indexPath.row]
        
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
}
