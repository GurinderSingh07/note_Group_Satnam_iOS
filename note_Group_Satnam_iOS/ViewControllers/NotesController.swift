//
//  NotesController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 27/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit
import CoreData

class NotesController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var optionButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIBarButtonItem!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBOutlet weak var tableNoteViews: UITableView!
    
    
    //MARK:- MemberVariables
    var editMode = false
    
    let searchController = UISearchController(searchResultsController: nil)
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var notes : [Note] = [Note]()
    var parentFolder : Folder?
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupInitials()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.toolbar.isHidden = false
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
        navigationController?.navigationBar.prefersLargeTitles = false
        self.enableSelection(editMode: false)
        self.navigationItem.title = parentFolder?.name
        showSearchBar()
        loadNotes()
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
    
    
    
    func loadNotes(predicate : NSPredicate? = nil,search: [NSSortDescriptor]?=nil)  {
        
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        if search != nil{
            request.sortDescriptors = search
        }else{
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        }
        let folderPredicate = NSPredicate(format: "parentFolder.name=%@", parentFolder!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [folderPredicate, additionalPredicate])
        } else {
            request.predicate = folderPredicate
        }
        do {
            self.notes = try self.context.fetch(request)
        } catch  {
            print(error)
        }
    }
    
    func enableSelection(editMode : Bool)  {
    
        self.navigationItem.setHidesBackButton(editMode, animated: true)
        deleteButton.isEnabled = editMode
        moveButton.isEnabled = editMode
        plusButton.isEnabled = !editMode
        optionButton.isEnabled = !editMode
        tableNoteViews.allowsMultipleSelectionDuringEditing = editMode
        tableNoteViews.setEditing(editMode, animated: true)
    }
    
    //MARK:- UIButtons
    @IBAction func editFunction(_ sender: UIBarButtonItem) {
        
        editMode = !editMode
        enableSelection(editMode: editMode)
    }
    
    @IBAction func optionButtonFunction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Do you want to sort notes?", message: "If yes, then Select any option to sort it.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "(A-Z) Ascending", style: .default, handler: {
            _ in
            
        }))
        alert.addAction(UIAlertAction(title: "(A-Z) Descending", style: .default, handler: {
            _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Date Ascending", style: .default, handler: {
            _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Date Descending", style: .default, handler: {
            _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func moveFunction(_ sender: Any) {
        
        if let indexPaths = self.tableNoteViews.indexPathsForSelectedRows{
            let rows = indexPaths.map{$0.row}
            let destinationView = self.storyboard?.instantiateViewController(identifier: "move_note_view") as! MoveNotesController
            destinationView.selectedNotes = rows.map{notes[$0]}
            destinationView.delegate = self
            self.present(destinationView, animated: true, completion: nil)
        }
    }
    
    @IBAction func createNoteFunction(_ sender: Any) {
        
        let destination = self.storyboard?.instantiateViewController(identifier: "create_note_view") as! CreateNoteController
        destination.parentFolder = self.parentFolder
        destination.delegate = self
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    @IBAction func deleteFunction(_ sender: Any) {
        
    }
}

extension NotesController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        // Set View Container corner radius
        cell.viewContainer.layer.cornerRadius = 5
        
        cell.lblTitle.text = "\(notes[indexPath.row].title ?? "")"
        cell.lblSubtitle.text = "Date:- \(Date.getDateWithFormat(date: notes[indexPath.row].date ?? Date()))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard !editMode else { return }
        let destinationView = self.storyboard?.instantiateViewController(identifier: "edit_note_view") as! EditNoteController
        destinationView.delegate = self
        destinationView.note = notes[indexPath.row]
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
}

//MARK: - search bar delegate methods
extension NotesController : UISearchBarDelegate {

    func showSearchBar() {
        //setting the delegate for searchbar
        searchController.searchBar.delegate = self
        // Set search bar textfield attributes.
        searchController.searchBar.placeholder = "Search Note"
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.searchBar.searchTextField.textColor = UIColor.black
        
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text:String = searchBar.text!
        if text.count == 0 {
            self.loadNotes()
        }else{
            //following is to filter notes with title or detail
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR detail CONTAINS[cd] %@", argumentArray: [text,text])
            self.loadNotes(predicate: predicate)
        }
        self.tableNoteViews.reloadData()
    }
    
}

extension Date {
    
    static func getDateWithFormat(date : Date) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy, hh:mm a"
        
        return dateFormatter.string(from: date)
    }
}

