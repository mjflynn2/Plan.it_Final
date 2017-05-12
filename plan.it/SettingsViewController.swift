//
//  SettingsViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 5/1/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    // reference to the Firebase data store
    var dbRef: FIRDatabaseReference!
    // reference to the Firebase storage
    var storage: FIRStorageReference!
    
    var imageURL = ""
    let uid = (FIRAuth.auth()?.currentUser?.uid)!
    
    var profileInfo = [String]()

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var profileBio: UITextField!
    
    
    @IBAction func submitChanges(_ sender: Any) {
        
        if (self.firstName.text?.characters.count)! > 0 {
            
            // update firstName to database
            
            self.dbRef.child("users/\(uid)/firstName").setValue(self.firstName.text)
        }
        
        if (self.lastName.text?.characters.count)! > 0 {
            
            // update lastName to database
            
            self.dbRef.child("users/\(uid)/lastName").setValue(self.lastName.text)
        }
        
        if (self.profileBio.text?.characters.count)! > 0 {
            
            // update bio to database
            
            self.dbRef.child("users/\(uid)/description").setValue(self.profileBio.text)
        }
        
        let alertController = UIAlertController(title: "Success", message: "You have successfully updated your account settings!", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func picChange(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        let imageData = UIImagePNGRepresentation(image)!
        
        // get reference to the location where we'll store our photos
        let userStorage = storage.child("userPhotos").child("\(self.uid).png")
        
        userStorage.put(imageData, metadata: nil, completion: { (metadata: FIRStorageMetadata?, error: Error?) in

            if error != nil {
                
                print("error is: ")
                print(error!)
            } else if let storageMetadata = metadata {
                
                if let imageURL = storageMetadata.downloadURL() {
                    
                    self.setImageURL(imageURL: imageURL.absoluteString)
                    
                    let data = NSData(contentsOf: imageURL)
                    let image = UIImage(data: data! as Data)
                    self.profileImage.image = image
                    
                    
                }
                
            }
        
            
        })
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // function to take the URL (text) and save it into database at imageString
    
    func setImageURL(imageURL: String) {
        
        
        print("imageURL is " + imageURL)
        
        self.dbRef.child("users/\(uid)/image").setValue(imageURL)
        
        
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
    
    func profileInfo(completion: @escaping (Array<String>) -> ()) {
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dict = snapshot.value as? NSDictionary {
                
                let first = dict["firstName"] as? String
                let last = dict["lastName"] as? String
                let bio = dict["description"] as? String
                
                var infoArray = [String]()
                infoArray.append(first!)
                infoArray.append(last!)
                infoArray.append(bio!)
                
                completion(infoArray)
                
            }
            
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        storage = FIRStorage.storage().reference()
        dbRef = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        self.profileImage.clipsToBounds = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.downloadImage()
        
        self.profileInfo { (profileinfo) -> () in
        
            self.profileInfo = profileinfo
            
            let firstName = self.profileInfo[0]
            let lastName = self.profileInfo[1]
            let bio = self.profileInfo[2]
            
            self.firstName.text = firstName
            self.firstName.textColor = UIColor.lightGray
            self.lastName.text = lastName
            self.lastName.textColor = UIColor.lightGray
            self.profileBio.text = bio
            self.profileBio.textColor = UIColor.lightGray
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
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
