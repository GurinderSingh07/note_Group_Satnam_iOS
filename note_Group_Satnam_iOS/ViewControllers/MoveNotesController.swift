//
//  MoveNotesController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 27/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit
import CoreData

class MoveNotesController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var navigationBarCustom: UINavigationBar!
    
    //MARK:- Member Variables
    var folders = [Folder]()
    var selectedNotes: [Note]? {
        didSet {
            loadFolders()
        }
    }
    var delegate : NotesController?
    // context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
    }
    
    func setupView(){
        
        // Set up navigation bar attributes properties.
        navigationBarCustom.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 20) ??
                UIFont.systemFont(ofSize: 20)]
    }

    func loadFolders() {
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()
        
        // predicate
        let folderPredicate = NSPredicate(format: "NOT name MATCHES %@", selectedNotes?[0].parentFolder?.name ?? "")
        request.predicate = folderPredicate
        
        do {
            folders = try context.fetch(request)
        } catch {
            print("Error fetching data \(error.localizedDescription)")
        }
    }
    
     //MARK:- UIButtons
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension MoveNotesController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.viewContainer.layer.cornerRadius = 5
        
        return cell
    }
}
