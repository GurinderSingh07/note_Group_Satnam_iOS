//
//  InitialData.swift
//  note_Group_Satnam_iOS
//
//  Created by SatnamSingh on 28/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class InitialData {
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private static var folders : [Folder] = [Folder]()
    private static var notes : [Note] = [Note]()
    
    private static func deleteData(){
        let request : NSFetchRequest<Folder> = Folder.fetchRequest()
        var folderlist : [Folder] = [Folder]()
        do {
            //following is to fetch all providers
            folderlist = try context.fetch(request)
            //following loop is to delete all the providers
            for folder in folderlist {
                context.delete(folder)
                try context.save()
            }
        } catch  {
            print(error)
        }
    }
    
    static func createInitialData(){
        deleteData()
        createFolder()
        notes = [Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context),Note(context: context)]
        
        //Following is data of notes
        notes[0].title = "Macbook Pro"
        notes[0].detail = "Premium Product with m1 Chip set"
        notes[0].date = Date()
        notes[0].latitude = 31.63
        notes[0].longitude = 74.87
        notes[0].parentFolder = folders[0]
        
        notes[1].title = "iPad Pro"
        notes[1].detail = "Pressure sensitive pencil with fast processor"
        notes[1].date = Date()
        notes[1].latitude = 31.63
        notes[1].longitude = 74.87
        notes[1].parentFolder = folders[0]
        
        notes[2].title = "iPhone XR"
        notes[2].detail = "Face recognition feature A12 Bionic"
        notes[2].date = Date()
        notes[2].latitude = 31.63
        notes[2].longitude = 74.87
        notes[2].parentFolder = folders[0]
        
        notes[3].title = "iPhone 11"
        notes[3].detail = "Dual camera with A13 Bionic"
        notes[3].date = Date()
        notes[3].latitude = 31.63
        notes[3].longitude = 74.87
        notes[3].parentFolder = folders[0]
        
        notes[4].title = "Microsoft Surface Pro 7"
        notes[4].detail = "Touch screen with Core i7"
        notes[4].date = Date()
        notes[4].latitude = 31.63
        notes[4].longitude = 74.87
        notes[4].parentFolder = folders[1]
        
        notes[5].title = "Microsoft Surface Pro X"
        notes[5].detail = "Touch screen with 15 hours of barttery and 128 gb ssd"
        notes[5].date = Date()
        notes[5].latitude = 31.63
        notes[5].longitude = 74.87
        notes[5].parentFolder = folders[1]
        
        notes[6].title = "Microsoft Surface Pro 6"
        notes[6].detail = "Core i7 and 256 HDD"
        notes[6].date = Date()
        notes[6].latitude = 31.63
        notes[6].longitude = 74.87
        notes[6].parentFolder = folders[1]
        
        notes[7].title = "Asus ROG Zephyrus S17"
        notes[7].detail = "RTX 3080 and 2TB SSD"
        notes[7].date = Date()
        notes[7].latitude = 31.63
        notes[7].longitude = 74.87
        notes[7].parentFolder = folders[2]
        
        notes[8].title = "bAsus ROG Zephyrus S17"
        notes[8].detail = "RTX 3080 and 2TB SSD"
        notes[8].date = Date()
        notes[8].latitude = 31.63
        notes[8].longitude = 74.87
        notes[8].parentFolder = folders[2]
        
        notes[9].title = "cAsus ROG Zephyrus S17"
        notes[9].detail = "RTX 3080 and 2TB SSD"
        notes[9].date = Date()
        notes[9].latitude = 31.63
        notes[9].longitude = 74.87
        notes[9].parentFolder = folders[2]
        
        notes[10].title = "dAsus ROG Zephyrus S17"
        notes[10].detail = "RTX 3080 and 2TB SSD"
        notes[10].date = Date()
        notes[10].latitude = 31.63
        notes[10].longitude = 74.87
        notes[10].parentFolder = folders[2]
        
        notes[11].title = "eAsus ROG Zephyrus S17"
        notes[11].detail = "RTX 3080 and 2TB SSD"
        notes[11].date = Date()
        notes[11].latitude = 31.63
        notes[11].longitude = 74.87
        notes[11].parentFolder = folders[2]
        
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    private static func createFolder(){
        //First folder
        var folder = Folder(context: context)
        folders.append(folder)
        folder.name = "Apple"
        
        //second folder
        folder = Folder(context: context)
        folders.append(folder)
        folder.name = "Microsoft"
        
        //Third folder
        folder = Folder(context: context)
        folders.append(folder)
        folder.name = "Asus"
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
}
