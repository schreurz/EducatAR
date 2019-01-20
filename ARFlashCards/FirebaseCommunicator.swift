//
//  FirebaseCommunicator.swift
//  ARFlashCards
//
//  Created by Zack Schreur on 1/19/19.
//  Copyright © 2019 Zack Schreur. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import Alamofire

class FirebaseCommunicator {
    var ref: DatabaseReference!
    var storage = Storage.storage()
    var imageRecieved = UIImage()
    var path=String()
    
    init() {
        ref = Database.database().reference()
        getFlashCard(name: "object")
    }
    
    func getFlashCard(name: String) {
        ref.child(name).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            print("key: ",snapshot.key)
            let value = snapshot.value as? NSDictionary
            print(value![0])
            })
    }
    
    func getFile()->String{
        
        // Create a reference from a Google Cloud Storage URI
        
//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let fileURL = documentsURL.appendingPathComponent("temp.scn")
//
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        Alamofire.download("https://firebasestorage.googleapis.com/v0/b/augmented-education.appspot.com/o/models%2Fship.scn?alt=media&token=d73a2e95-c85a-4e55-90e6-35e9983872d4", to: destination).response { response in
            if response.error == nil, let imagePath = response.destinationURL?.path {
                self.path = imagePath
                print("This is the response",response)
            }
            
        }
        return self.path
       
        
        // Create a reference from an HTTPS URL
        // Note that in the URL, characters are URL escaped!
    }
}
