//
//  ProfileViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/24/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var stats: UILabel!
    
    // reference to the Firebase data store
    
    var dbRef = FIRDatabase.database().reference()
    
    var storage = FIRStorage.storage().reference()
    
    let uid = (FIRAuth.auth()?.currentUser?.uid)!
    
    var imageURL = ""
    
    
    func getUserFullName(completion: @escaping (String) -> ()) {
        
        let uid = (FIRAuth.auth()?.currentUser?.uid)!
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let value = snapshot.value as? NSDictionary {
                
                let firstName = value["firstName"] as? String
                
                let lastName = value["lastName"] as? String
                
                let fullName = firstName! + " " + lastName!
                
                completion(fullName)
                
                
            } else {
                
                completion("")
            }
            
        })
        
        
        
    }
    
    func getBio(completion: @escaping (String) -> ()) {
        
        let uid = (FIRAuth.auth()?.currentUser?.uid)!
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let value = snapshot.value as? NSDictionary {
                
                let bioU = value["description"] as? String
                
                completion(bioU!)
                
                
            } else {
                
                completion("")
            }
            
        })

    }
    
    func downloadImage () {
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            
            if let firebaseValue = snapshot.value as? NSDictionary {
                
                self.imageURL = firebaseValue["image"] as! String
                
                print("self.imageURL :" + self.imageURL)
                
            }
            
            if self.imageURL.characters.count > 0 {
                
                print("there is more than 0 characters")
                
                let picURL = self.storage.child("userPhotos/\(self.uid).png")
                
                picURL.downloadURL { url, error in
                    
                    if let sessionError = error {
                        
                        print("error is :")
                        print(sessionError.localizedDescription)
                        
                    } else {
                        
                        let data = NSData(contentsOf: url!)
                        let image = UIImage(data: data! as Data)
                        self.profileImage.image = image
                        
                    }
                }
                
                
            }             
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)

        /*
        self.profileImage = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width * 0.19 , self.view.bounds.height * 0.1))
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.masksToBounds = false
        self.profileImage.layer.borderColor = UIColor.blackColor().CGColor
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        self.profileImage.clipsToBounds = true
        slider.addSubview(self.profileImage)
        */
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        self.profileImage.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.downloadImage()
        
        
        self.getUserFullName{ (fullname) -> () in
            
            if fullname.characters.count > 0 {
                
                self.fullName.text = fullname
                
            } else {
                
                print("Not found")
            }
            
        }
        
        self.getBio { (userBio) -> () in
            
            if userBio.characters.count > 0 {
                
                self.bio.text = userBio
                
            } else {
                
                self.bio.text = " "
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
