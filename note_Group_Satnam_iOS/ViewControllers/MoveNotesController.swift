//
//  MoveNotesController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 27/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class MoveNotesController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var navigationBarCustom: UINavigationBar!
    
    
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
