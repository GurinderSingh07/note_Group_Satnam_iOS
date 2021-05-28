//
//  EditNoteController.swift
//  note_Group_Satnam_iOS
//
//  Created by Gurinder Singh on 28/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation

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
    
    @IBOutlet weak var lblImageStatus: UILabel!
    
    //MARK:- MemberVariables
    var delegate : NotesController?
    var note : Note?
    var player = AVAudioPlayer()
    var fileName: String?
    
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
        if noteFetched.image != nil {
            lblImageStatus.text = ""
            imageView.image = UIImage(data: noteFetched.image!)
        }
        if noteFetched.voice == nil {
            spaceOnToolBar.text = "No Audio in note"
            playButton.isEnabled = false
            stopButton.isEnabled = false
        }else{
            
        }
 
        if noteFetched.latitude != 0 && noteFetched.longitude != 0 {
            self.setLocationOnMap(note: noteFetched)
        }
    }
    
    func setLocationOnMap(note:Note)  {
        //define span
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        //to print location coordinates of loaction that we get.
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
        if titleField.text == "" || detailField.text == "" {
            let alert = UIAlertController(title: "WARNING!", message: "Data should be filled properly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        note?.title = titleField.text
        note?.detail = detailField.text
        delegate?.loadNotes()
        delegate?.tableNoteViews.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- UIButtons
    @IBAction func stopButton(_ sender: UIButton) {
        
    }
    
    @IBAction func playPauseAudio(_ sender: Any) {
        
    }
}
//MARK: - AUDIO Extension
extension EditNoteController : AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupPlayer() {
        guard  fileName != nil else { return }
        print("file in edit note : - \(fileName ?? "")")
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName ?? "")
        do {
            try player = AVAudioPlayer(contentsOf: audioFilename)
            player.delegate = self
            player.prepareToPlay()
            player.volume = 1.0
        } catch {
            print(error)
        }
    }
}
