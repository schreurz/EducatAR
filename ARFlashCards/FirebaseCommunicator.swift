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

class FirebaseCommunicator {
    init() {
        var ref: DatabaseReference!
        var db_ref = Database.database().reference()
        
        var storage = Storage.storage()
        var str_ref = storage.reference()
    }
}
