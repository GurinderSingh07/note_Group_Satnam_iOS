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
    @IBOutlet weak var viewSlideBar: UIView!
    @IBOutlet weak var viewDescription: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var detailField: UITextView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var playButtonAudio: UIButton!
    @IBOutlet weak var crossButtonAudio: UIButton!
    @IBOutlet weak var sliderAudio: UISlider!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitials()
    }
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
        // Set navigation tool bar hidden
        self.navigationController?.toolbar.isHidden = true
        
        // Set title view attributes
        viewTitle.layer.cornerRadius = 10
        viewTitle.layer.borderWidth = 1
        viewTitle.layer.borderColor = UIColor.black.cgColor
        
        // Set map view attributes
        mapView.layer.cornerRadius = 10
        mapView.layer.borderWidth = 1
        mapView.layer.borderColor = UIColor.black.cgColor
        
        // Set image view attributes
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        
        // Set slide bar view attributes
        viewSlideBar.layer.cornerRadius = 10
        viewSlideBar.layer.borderWidth = 1
        viewSlideBar.layer.borderColor = UIColor.black.cgColor
        
        // Set detail field view attributes
        detailField.layer.cornerRadius = 10
        detailField.layer.borderWidth = 1
        detailField.layer.borderColor = UIColor.black.cgColor
    }
    
    //MARK:- UIButtons
    @IBAction func playAudioFunction(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteAudioFunction(_ sender: UIButton) {
        
    }
    
    @IBAction func addLocationButton(_ sender: UISwitch) {
        
    }
    
    @IBAction func addPhotoFunction(_ sender: UIButton) {
        
    }
    
    @IBAction func addAudioFunction(_ sender: UIButton) {
        
    }
}
