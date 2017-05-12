//
//  EventsMasterTableViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/17/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase


class EventsMasterTableViewController: UITableViewController {
    
    var detailViewController: EventDetailControllerViewController? = nil
    
    // This array will be the array of Events from database
    var objects = [Any]()
    
    var eventTitles = ["Concert", "Promotion Event", "Fundraiser"]
    
    var eventArray = [eventInfo]()
    
    let eventRep = FIRDatabase.database().reference().child("events")
    
    var eventKeys = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view, typically from a nib.
        
        // call function that will retrieveEvents and keep them updated as well
        
        self.retrieveEvents { (eventArrays) -> () in
            
            self.tableView.reloadData()
            
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        self.getAddedChildren { (eventArrays) -> () in
            
            self.tableView.reloadData()
        }
        */
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //let object = eventTitles[indexPath.row]
                print("indexPath.row :")
                print(indexPath.row)
                var eachEvent = eventInfo()
                
                let arrayCount = eventArray.count - 1
                let indexForArray = arrayCount - indexPath.row
                eachEvent = self.eventArray[indexForArray]

                let controller = (segue.destination as! UINavigationController).topViewController as! EventDetailControllerViewController
                //controller.detailItem = object
                print("eventKey is : " + eachEvent.eventKey)
                controller.detailItem = eachEvent.eventKey
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! EventViewCell
        
        print("in tableView?")
        var eachEvent = eventInfo()
        
        let arrayCount = eventArray.count - 1
        let indexForArray = arrayCount - indexPath.row
        
        print("index is : " + indexForArray.description)
        eachEvent = self.eventArray[indexForArray]
        let Title = eachEvent.eventTitle
        let Date = eachEvent.eventDate
        let Time = eachEvent.eventTime
        let rating = eachEvent.eventRating
        
        print("Title : " + Title)
        print("Date : " + Date)
        print("Time " + Time)
        
        cell.eventTitle.text = Title
        cell.eventDate.text = Date
        cell.eventTime.text = Time
        
        // TODO MARGOT for leafs
        if rating == 1 {
            // set photo to leaf for 1
            //example
            // cell.eventImage.image = blah
        } else if rating == 2 {
            // set photo to leaf for 2
        } else if rating == 3 {
            // set photo to leaf for 3
        } else if rating == 4 {
            // set photo for leaf for 4
        } else {
            // default do leaf for 1?
        }
         
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegue(withIdentifier: "eventDetail", sender: self)
    }
    */
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
 
    
    
    func retrieveEvents(completion: @escaping (Array<Any>) -> ()) {
        
        eventRep.observe(.value, with: { (snapshot) in
            
            print("get here? 1")
            
            if (snapshot.value is NSNull) {
                print("No Events")
            } else {
            
                for child in snapshot.children.allObjects {
                 
                    print("get here?")
                    let snap = child as! FIRDataSnapshot
     
                    print("key is : " + snap.key)
                
                    let uniqueKey = snap.key
                
                    let eachEvent = eventInfo()
                    
                    //let childSnapshot = snap.childSnapshot(forPath: (child as AnyObject).key)
                    //let Date = childSnapshot.value!["date"] as? NSString
                
                    if let snapshotChild = snap.value as? [String: Any] {
                        
                        print("number of snapChildren")
                        print(snapshotChild.count)
                        
                        let Title = snapshotChild["name"] as? String
                        let Date = snapshotChild["date"] as? String
                        let Time = snapshotChild["time"] as? String
                        let rating = snapshotChild["rating"] as? Int
                        
                        
                    
                        eachEvent.eventTitle = Title!
                        eachEvent.eventDate = Date!
                        eachEvent.eventTime = Time!
                        eachEvent.eventKey = uniqueKey
                        eachEvent.eventRating = rating!
                    
                        print("added Title :" + Title!)
                        print("added Date :" + Date!)
                        print("added Time :" + Time!)
                        print("added Key :" + uniqueKey)
                    
                        self.eventArray.append(eachEvent)
                    
                        //self.eventDict.updateValue(eachEvent, forKey: uniqueKey)
                    
                    }
                
                
                }
                completion(self.eventArray)
                print("out of for loop")
            }
            print("out of else case")
            //self.eventRep.removeAllObservers()
            
        })
        print("reloadData")
        self.tableView.reloadData()
 
                
        // need add EventTitle, EventData, EventTime to an instance of eventInfo
                
        // need to add eventKey to EventsArray key and the instance of eventInfo as value
        
            
        
    }
    
    
    func getAddedChildren(completion: @escaping (Array<Any>) -> ()) {
        
        eventRep.observe(.childAdded, with: { (snapshot) in
            
            if (snapshot.value is NSNull) {
                print("No Events")
            } else {
                
                for child in snapshot.children.allObjects {
                    
                    print("get here?")
                    let snap = child as! FIRDataSnapshot
                    
                    print("key is : " + snap.key)
                    
                    let uniqueKey = snap.key
                    
                    let eachEvent = eventInfo()
                    
                    
                    if let snapshotChild = snap.value as? [String: Any] {
                        
                        print("number of snapChildren")
                        print(snapshotChild.count)
                        
                        let Title = snapshotChild["name"] as? String
                        let Date = snapshotChild["date"] as? String
                        let Time = snapshotChild["time"] as? String
                        
                        
                        
                        eachEvent.eventTitle = Title!
                        eachEvent.eventDate = Date!
                        eachEvent.eventTime = Time!
                        eachEvent.eventKey = uniqueKey
                        
                        print("added Title :" + Title!)
                        print("added Date :" + Date!)
                        print("added Time :" + Time!)
                        print("added Key :" + uniqueKey)
                        
                        self.eventArray.append(eachEvent)
                        
                    
                    }
                    
                }
            }
        })
    }
    
    
}



