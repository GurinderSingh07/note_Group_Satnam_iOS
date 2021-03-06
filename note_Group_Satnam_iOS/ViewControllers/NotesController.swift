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
    
    //MARK:- Initial value
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
    
    //MARK:- delete and load
	func deleteNote(note:Note)  {
        do {
            context.delete(note)
            try context.save()
        } catch  {
            print(error)
        }
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
    
    //MARK:- Edit button
    @IBAction func editFunction(_ sender: UIBarButtonItem) {
        
        editMode = !editMode
        enableSelection(editMode: editMode)
    }
    
    //MARK:- sort button
    @IBAction func optionButtonFunction(_ sender: Any) {
        
		let alert = UIAlertController(title: "Do you want to sort notes?", message: "If yes, then Select any option to sort it.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Title Ascending", style: .default, handler: {
            _ in
            self.loadNotes(predicate: nil, search: [NSSortDescriptor(key: "title", ascending: true)])
            self.tableNoteViews.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Title Descending", style: .default, handler: {
            _ in
            self.loadNotes(predicate: nil, search: [NSSortDescriptor(key: "title", ascending: false)])
            self.tableNoteViews.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Date Ascending", style: .default, handler: {
            _ in
            self.loadNotes(predicate: nil, search: [NSSortDescriptor(key: "date", ascending: true)])
            self.tableNoteViews.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Date Descending", style: .default, handler: {
            _ in
            self.loadNotes(predicate: nil, search: [NSSortDescriptor(key: "date", ascending: false)])
            self.tableNoteViews.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
		
    }
    
    //MARK:- Move button
    @IBAction func moveFunction(_ sender: Any) {
        
        if let indexPaths = self.tableNoteViews.indexPathsForSelectedRows{
            let rows = indexPaths.map{$0.row}
            let destinationView = self.storyboard?.instantiateViewController(identifier: "move_note_view") as! MoveNotesController
            destinationView.selectedNotes = rows.map{notes[$0]}
            destinationView.delegate = self
            self.present(destinationView, animated: true, completion: nil)
        }
    }
    
    //MARK:- create note
    @IBAction func createNoteFunction(_ sender: Any) {
        
        let destination = self.storyboard?.instantiateViewController(identifier: "create_note_view") as! CreateNoteController
        destination.parentFolder = self.parentFolder
        destination.delegate = self
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    //MARK:- Delete button for multiple delete
    @IBAction func deleteFunction(_ sender: Any) {
		if let indexPaths = self.tableNoteViews.indexPathsForSelectedRows {
            let alert = UIAlertController(title: "Delete notes", message: "Are you sure?", preferredStyle: .actionSheet)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler:{ _ in
                let rows = (indexPaths.map {$0.row}).sorted(by: >)
                let _ = rows.map {self.deleteNote(note: self.notes[$0])}
                self.loadNotes()
                self.tableNoteViews.reloadData()
                self.editMode = !self.editMode
                self.enableSelection(editMode: self.editMode)
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(deleteButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK:- Table functions
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
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure to delete note ?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {
                _ in
                self.deleteNote(note: self.notes[indexPath.row])
                self.loadNotes()
                self.tableNoteViews.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tableNoteViews.reloadData()
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       self.loadNotes()
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

