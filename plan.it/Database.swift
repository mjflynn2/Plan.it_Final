//
//  Database.swift
//  plan.it
//
//  Created by Daniel Silva on 4/6/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import Foundation
import Firebase


class DB {
    
    var testUser: User?
    
    // reference to the Firebase data store
    private var dbRef : FIRDatabaseReference!
    
    // where the Users will be stored
    private var usersDB : FIRDatabaseReference
    
    // reference for interests
    //private var interestRef : FIRDatabaseReference
    
    var name: String
    
    init() {
        
        self.dbRef = FIRDatabase.database().reference()
        
        // sets the reference to the Users part of the database
        self.usersDB = self.dbRef.child("users")
        
        // intialize interest reference
        //self.interestRef = self.usersDB.child("interests")
        
        name = ""
        
    }
    
    func insertNewUser(email: String, description: String, events: String, favorites: String, followers: String, following: String, image: String, interests: Array<Bool>, firstName: String, lastName: String, notifications: String, sustainabilityScore: Int, type: Int) {
        
        // gets the randomized key for the user
        //let key = self.usersDB.childByAutoId().key
        
        let key = FIRAuth.auth()!.currentUser!.uid
        
        let user : NSDictionary = ["email" : email, "description" : description, "events" : events, "favorites" : favorites, "followers" : followers, "following" : following, "image" : image, "interests" : interests, "firstName" : firstName, "lastName" : lastName, "notifications" : notifications, "sustainabilityScore" : sustainabilityScore, "type" : type]
        
        self.usersDB.updateChildValues(["/\(key)" : user])
        
    }
    
    func updateInterests(arrayofInterests: Array<Bool>) {
        
        let key = FIRAuth.auth()!.currentUser!.uid
        
        self.dbRef.child("users/\(key)/interests").setValue(arrayofInterests)
        
        //self.usersDB.child("\(key)")
        
        //self.interestRef.updateChildValues(["/interests/\(key)" : arrayofInterests])
        
    }
    
    /*
    
    func getUserFullName() {
        
        let key = FIRAuth.auth()?.currentUser?.uid
        
        print(key!)
        
        self.dbRef.child("users").child(key!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let firstName = value?["firstName"] as! String
            
            let lastName = value?["lastName"] as! String
            
            let fullName = firstName + " " + lastName
            
            let user = User.init(fullName: fullName)
            
            //self.name = fullName
            
            self.testUser = user
            
            print("1" + (self.testUser?.fullName)!)
            
        })
        
        print("work?" + (self.testUser?.fullName)!)
        
    }
 
    */
    
    
    
    
    
    
    
    
}
