//
//  EventDetailControllerViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/17/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase

class EventDetailControllerViewController: UIViewController {
    
    let eventReference = FIRDatabase.database().reference().child("events")
    
    var dbRef: FIRDatabaseReference!
    var storage = FIRStorage.storage().reference()
    
    let uid = (FIRAuth.auth()?.currentUser?.uid)!

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventPrice: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    
    @IBOutlet var rsvpButton: UIButton!
    
    var eventDict = [String: String] ()
    
    var eventLink : String = ""
    
    var uniqueKeyId : String = ""
    
    @IBAction func rsvpButton(_ sender: Any) {
        
        if (self.uniqueKeyId.characters.count > 0) {
            
            self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let value = snapshot.value as? NSDictionary {
                    
                    // Fetch RSVP array from database for user
                    var rsvpArray = [String]()
                    rsvpArray = (value["rsvps"] as? [String])!
                    
                    // Check if user is already RSVP'd for the event
                    // _____________________________________________//
                    
                    // User has not already RSVP'd
                    if (!rsvpArray.contains(self.uniqueKeyId)){
                        
                        // Add event to RSVP array
                        rsvpArray.append(self.uniqueKeyId)
                        
                        // Update database with new RSVP
                        self.dbRef.child("users/\(self.uid)/rsvps").setValue(rsvpArray)
                        
                        // Set RSVP button to "clicked" appearance
                        self.rsvpButton.setImage(UIImage(named: "Asset 44@0.5x.png"), for: UIControlState.normal)
                        
                       // Update Sustainability Score for user
                        let user = DB()
                        user.updateSustainabilityScore(addedNumber: 10)
                        
                        // Confirm RSVP with alert
                        let alertController = UIAlertController(title: "You're All Set!", message: "You have successfully RSVP'd and 10 points have been added to your Sustainability Score!", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    // _____________________________________________//
                   
                    // User has already RSVP'd
                    } else {
                        
                        // Notify user that they have already RSVP'd with alert
                        let alertController = UIAlertController(title: "Oops!", message: "You already RSVP'd to this event. Go to the My Events Tab to see all your active events.", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    // _____________________________________________//
                    
                }
                
                
            })
            
        } else {
            
            print("key is empty")
        }
    }
    
    
    
    @IBAction func inviteButton(_ sender: Any) {
        
        /*
        if let invite = FIRInvites.inviteDialog() {
            invite.setInviteDelegate(self as! FIRInviteDelegate)
            
            // NOTE: You must have the App Store ID set in your developer console project
            // in order for invitations to successfully be sent.
            
            // A message hint for the dialog. Note this manifests differently depending on the
            // received invitation type. For example, in an email invite this appears as the subject.
            invite.setMessage("Try this out!\n -\(FIRAuth.auth()?.currentUser?.displayName ?? "")")
            // Title for the dialog, this is what the user sees before sending the invites.
            invite.setTitle("Plan.it")
            //invite.setDeepLink("app_url")
            invite.setCallToActionText("Install!")
            //invite.setCustomImage("https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png")
            invite.open()
        }
        */
        // needs functionality to invite event with others through text message
    }
    
    @IBAction func getTicketsButton(_ sender: Any) {

        
        let URLString = self.eventLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let linkURL = NSURL(string: URLString!)

        if UIApplication.shared.canOpenURL(linkURL! as URL) {
            
            UIApplication.shared.open(linkURL! as URL, options: [:], completionHandler: { (success) in
                print("Open URL Successfully : \(success)")
                
            })
            
            
        } else {
            
            UIApplication.shared.open(URL(string: "http://www.google.com")!)
        }
    
    }
    
    
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let detail = self.detailItem {
            print("key is : " + detail)
            
            self.uniqueKeyId = detail
            
        }
    }
    
    func getEventInfo(completion: @escaping ([String: String]) -> ()) {
        
        self.eventReference.child(uniqueKeyId).observeSingleEvent(of: .value, with: { (snapshot) in
    
            if let value = snapshot.value as? NSDictionary {
                
                self.eventDict.updateValue((value["name"] as? String)!, forKey: "name")
                self.eventDict.updateValue((value["date"] as? String)!, forKey: "date")
                self.eventDict.updateValue((value["time"] as? String)!, forKey: "time")
                self.eventDict.updateValue((value["location"] as? String)!, forKey: "location")
                self.eventDict.updateValue((value["price"] as? String)!, forKey: "price")
                self.eventDict.updateValue((value["description"] as? String)!, forKey: "description")
                self.eventDict.updateValue((value["link"] as? String)!, forKey: "link")
                
                completion(self.eventDict)
            }
            
            
        })
        
    }
    
    func downloadingImage(uniqueKey: String) {
        
        print("uniqueKey")
        print(uniqueKey)
        
        
        self.dbRef.child("users").child(uid).child("image").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.value is NSNull {
                print("error")
            } else {
                
                let imageString = snapshot.value as! String
                
                if imageString.characters.count > 0 {
                    
                    let imageURL = self.storage.child("eventPhotos/\(uniqueKey).png")
                    
                    imageURL.downloadURL { url, error in
                        
                        if let sessionError = error {
                            
                            print("error is :")
                            print(sessionError.localizedDescription)
                            
                        } else {
                            
                            let data = NSData(contentsOf: url!)
                            let image = UIImage(data: data! as Data)
                            self.eventImage.image = image
                            
                        }
                    }

                }

            }
            
            
                
            
            
        })
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        eventDescription.isScrollEnabled = false
        
        dbRef = FIRDatabase.database().reference()
        
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        eventDescription.isScrollEnabled = true
        
        self.downloadingImage(uniqueKey: self.uniqueKeyId)
        
        // call functions to load all the information for event
        self.getEventInfo { (eventDictionary) -> () in
        
            self.eventTitle.text = eventDictionary["name"]
            self.eventDate.text = eventDictionary["date"]
            self.eventTime.text = eventDictionary["time"]
            self.eventLocation.text = eventDictionary["location"]
            self.eventPrice.text = eventDictionary["price"]
            self.eventDescription.text = eventDictionary["description"]
            
            self.eventLink = eventDictionary["link"]!
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

}
