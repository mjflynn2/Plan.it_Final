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
    @IBOutlet weak var sustainabilityScore: UILabel!
    @IBOutlet weak var sustainableTitle: UILabel!
    @IBOutlet var ScoreImage: UIImageView!
    
    
    
    // reference to the Firebase data store
    
    var dbRef = FIRDatabase.database().reference()
    
    var storage = FIRStorage.storage().reference()
    
    let uid = (FIRAuth.auth()?.currentUser?.uid)!
    
    var imageURL = ""
    
    
    func getUserFullName(completion: @escaping (String) -> ()) {
        
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
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let value = snapshot.value as? NSDictionary {
                
                let bioU = value["description"] as? String
                
                completion(bioU!)
                
                
            } else {
                
                completion("")
            }
            
        })

    }
    
    func getSustainabilityScore(completion: @escaping (Int) -> ()) {
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let value = snapshot.value as? NSDictionary {
                
                let score = value["sustainabilityScore"] as? Int
                
                completion(score!)
                
            } else {
                
                let nullValue = 0
                completion(nullValue)
            }
        })
    }
    
    func downloadImage () {
        
        self.dbRef.child("users").child(uid).child("image").observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            
            if snapshot.value is NSNull {
                print("error")
            } else {
                
                self.imageURL = snapshot.value as! String
                
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

        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        self.profileImage.clipsToBounds = true
        
        //let rsvpEvents = UITableView(frame: view.bounds)
        //view.addSubview(rsvpEvents)
        //self.rsvpEvents = rsvpEvents
        
        //self.rsvpEvents.register(EventViewCell.self, forCellReuseIdentifier: "customCell")
        
        
        
        //rsvpEvents.dataSource = self as UITableViewDataSource
        //rsvpEvents.delegate = self as UITableViewDelegate
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
        
        self.getSustainabilityScore { (score) -> () in
            
            if score > 0 {
                
                self.sustainabilityScore.text = score.description
                
                if score > 0 && score < 20 {
                    
                    // sustainability seedling
                    self.ScoreImage.image = UIImage(named: "SustainabilityScore_1.png")
                    self.sustainableTitle.text = "Sustainability Seedling"
                    
                } else if score >= 20 && score < 40 {
                    
                    // sustainability sprout
                    self.ScoreImage.image = UIImage(named: "SustainabilityScore_2.png")
                    self.sustainableTitle.text = "Sustainability Sprout"
                    
                } else if score >= 40 && score < 60 {
                    
                    // sustainability sapling
                    self.ScoreImage.image = UIImage(named: "SustainabilityScore_3.png")
                    self.sustainableTitle.text = "Sustainability Sapling"
                    
                } else if score >= 60 && score < 80 {
                    
                    // sustainably star
                    self.ScoreImage.image = UIImage(named: "SustainabilityScore_4.png")
                    self.sustainableTitle.text = "Sustainability Star"
                    
                } else if score >= 80 {
                    
                    // sustainability superstar
                    self.ScoreImage.image = UIImage(named: "SustainabilityScore_5.png")
                    self.sustainableTitle.text = "Sustainability Superstar"
                    
                }
                
            } else {
                
                self.sustainabilityScore.text = "0"
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

/*
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return elements.count
        return basicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! EventViewCell
        //var cell: EventViewCell
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? EventViewCell {
            
            let title = basicArray[indexPath.row]
            cell.eventTitle.text = title
            
            
        }
        
        //(cell as! EventViewCell).eventTitle.text = basicArray[indexPath.row]
        
        
        
        
        
        /*
         print("in tableView?")
         var eachEvent = eventInfo()
         
         let arrayCount = eventArray.count - 1
         let indexForArray = arrayCount - indexPath.row
         
         print("index is : " + indexForArray.description)
         eachEvent = self.eventArray[indexForArray]
         let Title = eachEvent.eventTitle
         let Date = eachEvent.eventDate
         let Time = eachEvent.eventTime
         
         l
         
         print("Title : " + Title)
         print("Date : " + Date)
         print("Time " + Time)
         
         cell.eventTitle.text = Title
         cell.eventDate.text = Date
         cell.eventTime.text = Time
         print("almost returning cell")
         */
        
        //let title = basicArray[indexPath.row]
        
        //cell.eventTitle.text = title
        
        //cell.eventTitle.text = title
        
        
        
        return cell
    }
    
}
*/
