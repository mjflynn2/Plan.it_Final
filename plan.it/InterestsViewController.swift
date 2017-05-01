//
//  InterestsViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/6/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.


import UIKit
import FirebaseAuth
import Firebase

var interestsArray: [Bool] = [false, false, false, false, false, false, false, false]


class InterestsViewController: UIViewController {
    
//    @IBOutlet var step: UILabel!
    //currently says interests
    @IBOutlet weak var titleOutlet: UILabel!
    
    // need to get the current user's data by reference
    let currentUser = FIRAuth.auth()?.currentUser?.uid
    
    
    
    // isPressed buttons to keep track of whether that category button is pressed or not
    @IBOutlet var musicButton: UIButton!
    @IBOutlet var socialButton: UIButton!
    @IBOutlet var sportsButton: UIButton!
    @IBOutlet var artsButton: UIButton!
    
    var musicIsPressed: Bool = false
    var socialIsPressed: Bool = false
    var sportsIsPressed: Bool = false
    var artsIsPressed: Bool = false
    
    
    @IBOutlet weak var musicOutlet: UILabel!
    @IBOutlet weak var socialOutlet: UILabel!
    @IBOutlet weak var sportsOutlet: UILabel!
    @IBOutlet weak var artsOutlet: UILabel!
    
    func updateInterestArray(interestNumber: Int, buttonStatus: Bool) {
        
        if buttonStatus == false {
            
            interestsArray[interestNumber] = false
            
        } else {
            
            interestsArray[interestNumber] = true
        }
        
        print(interestsArray)
        
        /*
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("interests").observe(.value, with: {
            snapshot in
            
            if snapshot.value is NSNull {
                print("not found")
            } else {
                
            }
        })
        */
    }
    
    @IBAction func musicButton(_ sender: Any) {
        
        if musicIsPressed == false {
            // button is not pressed yet, pressing it
            
            musicIsPressed = true
            
            // change image for button (filled circle?)
            musicButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 0, buttonStatus: musicIsPressed)
            
        }
        
        else if musicIsPressed == true {
            // button is already pressed and we are unpressing it
            
            musicIsPressed = false
            
            
            // change image for button (unfilled circle?)
            musicButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 0, buttonStatus: musicIsPressed)
            
        }
    }
    
    @IBAction func socialButton(_ sender: Any) {
        
        if socialIsPressed == false {
            // button is not pressed yet, pressing it
            
            socialIsPressed = true
            
            // change image for button (filled circle?)
            socialButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 1, buttonStatus: socialIsPressed)
            
        }
            
        else if socialIsPressed == true {
            // button is already pressed and we are unpressing it
            
            socialIsPressed = false
            
            // change image for button (unfilled circle?)
            socialButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 1, buttonStatus: socialIsPressed)
            
        }
    }
   
    @IBAction func sportsButton(_ sender: Any) {
        
        if sportsIsPressed == false {
            // button is not pressed yet, pressing it
            
            sportsIsPressed = true
            
            // change image for button (filled circle?)
            sportsButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 2, buttonStatus: sportsIsPressed)
            
        }
            
        else if sportsIsPressed == true {
            // button is already pressed and we are unpressing it
            
            sportsIsPressed = false
            
            // change image for button (unfilled circle?)
            sportsButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 2, buttonStatus: sportsIsPressed)
            
        }
    }
    
    @IBAction func artsButton(_ sender: Any) {
        
        if artsIsPressed == false {
            // button is not pressed yet, pressing it
            
            artsIsPressed = true
            
            // change image for button (filled circle?)
            artsButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 3, buttonStatus: artsIsPressed)
            
        }
            
        else if artsIsPressed == true {
            // button is already pressed and we are unpressing it
            
            artsIsPressed = false
            
            // change image for button (unfilled circle?)
            artsButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 3, buttonStatus: artsIsPressed)
            
        }
    
    }
    

    override func viewDidLoad() {

        // Do any additional setup after loading the view.

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
