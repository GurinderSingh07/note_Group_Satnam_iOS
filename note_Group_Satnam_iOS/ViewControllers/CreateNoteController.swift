//
//  CreateNoteController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 28/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class CreateNoteController: UIViewController {

    //MARK:- IBOutlets
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitials()
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
        self.navigationController?.toolbar.isHidden = true
    }
    
    //MARK:- UIButtons
}
