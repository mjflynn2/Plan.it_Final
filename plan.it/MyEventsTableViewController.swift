//
//  MyEventsTableViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 5/11/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase

class MyEventsTableViewController: UITableViewController {
    
    var eventArray = [eventInfo]()
    
    let eventRep = FIRDatabase.database().reference().child("events")
    let userRep = FIRDatabase.database().reference().child("users")
    let uid = (FIRAuth.auth()?.currentUser?.uid)!
    var eventKeys = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("get here?")
        DispatchQueue.main.async {
            self.getEventRSVP { (eventArray) -> () in
                
                print("get here2?")
                print("eventArray.count :")
                print(eventArray.count)
                self.eventKeys = eventArray
                print("eventKeys.count :")
                print(self.eventKeys.count)
                self.eventKeys.remove(at: 0)
                print("eventKeys.count after removing dummy element")
                
                for eachKey in self.eventKeys {
                    
                    print(eachKey)
                    self.getEventInfoByKey(eachKey: eachKey) { (eachEvent) -> () in
                        print("appending eachKey")
                        self.eventArray.append(eachEvent)
                        self.tableView.reloadData()
                    }
                    
                    // call method to get eventInfo based on eventKey
                    
                }
                print("reloadingData")
                //self.tableView.reloadData()
                
            }
            
        }
        
        print("get here instead")
        //self.tableView.reloadData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func getEventRSVP(completion: @escaping (Array<String>) -> ()) {
        
        self.userRep.child(uid).child("rsvps").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (snapshot.value is NSNull) {
                print("error")
            } else {
                let array = snapshot.value as! NSArray
                var finalArray = [String]()
                
                for eachString in array {
                    finalArray.append(eachString as! String)
                }
                
                completion(finalArray)
            }
            
        })
        
        
    }
    
    func getEventInfoByKey(eachKey: String, completion: @escaping (eventInfo) -> ()) {
        
        self.eventRep.child(eachKey).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let child = snapshot.value as? NSDictionary {
                
                let Title = child["name"] as? String
                let Date = child["date"] as? String
                let Time = child["time"] as? String
                let rating = child["rating"] as? Int
                
                let eachEvent = eventInfo()
                
                eachEvent.eventTitle = Title!
                eachEvent.eventDate = Date!
                eachEvent.eventTime = Time!
                eachEvent.eventRating = rating!
                
                
                completion(eachEvent)
                //self.eventArray.append(eachEvent)
                
            }
            
            
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MyEventsTableViewCell
        
        var eachRSVP = eventInfo()
        
        eachRSVP = self.eventArray[indexPath.row]
        
        let Title = eachRSVP.eventTitle
        let Date = eachRSVP.eventDate
        let Time = eachRSVP.eventTime
        let rating = eachRSVP.eventRating
        
        print("Title is :" + Title)
        print("Data is : " + Date)
        print("Time is : " + Time)
        
        
        cell.eventTitle.text = Title
        cell.eventDate.text = Date
        cell.eventTime.text = Time
        
        // TODO MARGOT for leafs
         if rating == 1 {
         // set photo to leaf for 1
            //example
            // self.leafImage.image = blah
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
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
