//
//  EditNoteController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 28/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit
import MapKit

class EditNoteController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate{
    
    //MARK:- IBOutlets
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewDescription: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var detailField: UITextView!
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var spaceOnToolBar: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var delegate : NotesController?
    var note : Note?
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitials()
        fetchNote()
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
        mapView.delegate = self
        
        // Set image view attributes
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        
        // Set detail field view attributes
        detailField.layer.cornerRadius = 10
        detailField.layer.borderWidth = 1
        detailField.layer.borderColor = UIColor.black.cgColor
        
        // Set navigation bar right bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveData))
    }
    
    private func fetchNote()  {
        guard let noteFetched = note else { return }
        titleField.text = noteFetched.title
        dateLabel.text = "Created: - \(Date.getDateWithFormat(date: noteFetched.date ?? Date()))"
        detailField.text = noteFetched.detail
        if noteFetched.image == nil {
            imageView.image = UIImage(named: "no_image_found.jpg")
        }else{
            imageView.image = UIImage(data: noteFetched.image!)
        }
        if noteFetched.voice == nil {
            spaceOnToolBar.text = "No Audio in note"
            playButton.isEnabled = false
            stopButton.isEnabled = false
        }else{
            
        }
 
        if noteFetched.latitude == 0 && noteFetched.longitude == 0 {
            
        }else{
            
        }
    }
    
    func setLocationOnMap(note:Note)  {
        //define span
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        print("got location: \(note.latitude) , \(note.longitude)")
        //get location
        let location = CLLocationCoordinate2D(latitude: note.latitude, longitude: note.longitude)
        
        //define region where we want to display marker
        let region = MKCoordinateRegion(center: location, span: span)
        
        //set region and for smooth animation.
        mapView.setRegion(region, animated: true)
        //adding annotation
        let annotation = MKPointAnnotation()
        annotation.title = "Where Note is created"
        annotation.subtitle = "Created:- \(Date.getDateWithFormat(date: note.date ?? Date()))"
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
    }
    
    @objc func saveData(){
        
    }
    
    //MARK:- UIButtons
    @IBAction func stopButton(_ sender: UIButton) {
        
    }
    
    @IBAction func playPauseAudio(_ sender: Any) {
        
    }
}
