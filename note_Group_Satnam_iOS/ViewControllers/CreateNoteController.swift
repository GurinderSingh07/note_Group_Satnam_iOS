//
//  CreateNoteController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 28/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class CreateNoteController: UIViewController ,CLLocationManagerDelegate
                            ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

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
    
    //MARK:- MemberVariables
    private var userLocation : CLLocation?
    private var isLocationEnabled = false
    var parentFolder : Folder?
    var delegate : NotesController?
    var locationManager = CLLocationManager()
    
    //MARK: - Image member variables
    private var selectedImage : UIImage?
    let imagePicker = UIImagePickerController()
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitials()
    }
    
    //MARK:- PrivateMethods
    private func setupInitials(){
        
        imagePicker.delegate = self
        //assigning location delegate
        locationManager.delegate = self
        //for accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //requesting location
        locationManager.requestWhenInUseAuthorization()
        //start location update
        locationManager.startUpdatingLocation()
        
        //setting initial GUI for audio player
        playButtonAudio.isEnabled = false
        crossButtonAudio.isEnabled = false
        sliderAudio.value = 0
        sliderAudio.isEnabled = false
        
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
        
        // Set navigation bar right bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveData))
    }
    
    //MARK: - To fetech location
    //this function is called whenever user location is changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation  = locations[0]
        
    }
    
    @IBAction func addLocationButton(_ sender: UISwitch) {
        guard userLocation != nil else {
            sender.setOn(false, animated: true)
            let alert = UIAlertController(title: "Error", message: "Location permission not available.\nPlease allow location in settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        isLocationEnabled = !isLocationEnabled
        if isLocationEnabled{
            self.mapView.showsUserLocation = true
            
            //define span
            let latDelta:CLLocationDegrees = 0.1
            let longDelta:CLLocationDegrees = 0.1
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            
            //get location
            let location = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
            
            //define region where we want to display marker
            let region = MKCoordinateRegion(center: location, span: span)
            
            //set region and for smooth animation.
            mapView.setRegion(region, animated: true)
        }else{
            self.mapView.showsUserLocation = false
        }
    }

    
    @IBAction func addPhotoFunction(_ sender: UIButton) {
        
    }
    
    @objc func saveData(){
        
    }
    
    //MARK:- UIButtons
    @IBAction func playAudioFunction(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteAudioFunction(_ sender: UIButton) {
        
    }
   
    @IBAction func addAudioFunction(_ sender: UIButton) {
        
    }
}
