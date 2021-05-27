//
//  CreateNoteController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 28/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit
import MapKit

class CreateNoteController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewDescription: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var viewSlideBar: UIView!
    
    @IBOutlet weak var detailField: UITextView!
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitials()
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
        self.navigationController?.toolbar.isHidden = true
        
        viewTitle.layer.cornerRadius = 10
        viewTitle.layer.borderWidth = 1
        viewTitle.layer.borderColor = UIColor.black.cgColor
        
//        viewDescription.layer.cornerRadius = 10
//        viewDescription.layer.borderWidth = 1
//        viewDescription.layer.borderColor = UIColor.black.cgColor
        
        mapView.layer.cornerRadius = 10
        mapView.layer.borderWidth = 1
        mapView.layer.borderColor = UIColor.black.cgColor
        
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        
        viewSlideBar.layer.cornerRadius = 10
        viewSlideBar.layer.borderWidth = 1
        viewSlideBar.layer.borderColor = UIColor.black.cgColor
        
        detailField.layer.cornerRadius = 10
        detailField.layer.borderWidth = 1
        detailField.layer.borderColor = UIColor.black.cgColor
    }
    
    //MARK:- UIButtons
}
