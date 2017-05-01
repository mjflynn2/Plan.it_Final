//
//  Interests2ViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/6/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit

class Interests2ViewController: UIViewController {
    
//    @IBOutlet var step: UILabel!
    //currently says Interests
    @IBOutlet weak var titleOutlet: UILabel!
    
    @IBOutlet var outdoorsButton: UIButton!
    @IBOutlet var culturalButton: UIButton!
    @IBOutlet var professionalButton: UIButton!
    @IBOutlet var specialButton: UIButton!
    // is pressed buttons 
    
    var outdoorsIsPressed: Bool = false
    var culturalIsPressed: Bool = false
    var professionalIsPressed: Bool = false
    var specialIsPressed: Bool = false
    
    @IBOutlet weak var outdoorsOutlet: UILabel!
    @IBOutlet weak var culturalOutlet: UILabel!
    @IBOutlet weak var professionalOutlet: UILabel!
    @IBOutlet weak var specialOutlet: UILabel!
    
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
    
    @IBAction func outdoorsButton(_ sender: Any) {
        
        if outdoorsIsPressed == false {
            // button is not pressed yet, pressing it
            
            outdoorsIsPressed = true
            
            // change image for button (filled circle?)
            outdoorsButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 4, buttonStatus: outdoorsIsPressed)
            
        }
            
        else if outdoorsIsPressed == true {
            // button is already pressed and we are unpressing it
            
            outdoorsIsPressed = false
            
            // change image for button (unfilled circle?)
            outdoorsButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 4, buttonStatus: outdoorsIsPressed)
            
        }

        
        
    }
    
    @IBAction func culturalButton(_ sender: Any) {
        
        if culturalIsPressed == false {
            // button is not pressed yet, pressing it
            
            culturalIsPressed = true
            
            // change image for button (filled circle?)
            culturalButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 5, buttonStatus: culturalIsPressed)
            
        }
            
        else if culturalIsPressed == true {
            // button is already pressed and we are unpressing it
            
            culturalIsPressed = false
            
            // change image for button (unfilled circle?)
            culturalButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 5, buttonStatus: culturalIsPressed)
            
        }

    }
    
    
    @IBAction func professionalButton(_ sender: Any) {
        
        if professionalIsPressed == false {
            // button is not pressed yet, pressing it
            
            professionalIsPressed = true
            
            // change image for button (filled circle?)
            professionalButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 6, buttonStatus: professionalIsPressed)
            
        }
            
        else if professionalIsPressed == true {
            // button is already pressed and we are unpressing it
            
            professionalIsPressed = false
            
            // change image for button (unfilled circle?)
            professionalButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 6, buttonStatus: professionalIsPressed)
            
        }

    }
    
    
    @IBAction func specialButton(_ sender: Any) {
        
        if specialIsPressed == false {
            // button is not pressed yet, pressing it
            
            specialIsPressed = true
            
            // change image for button (filled circle?)
            specialButton.setImage(UIImage(named: "Asset 3@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 7, buttonStatus: specialIsPressed)
            
        }
            
        else if specialIsPressed == true {
            // button is already pressed and we are unpressing it
            
            specialIsPressed = false
            
            // change image for button (unfilled circle?)
            specialButton.setImage(UIImage(named: "Asset 1@0.5x.png"), for: UIControlState.normal)
            
            // update boolean status of interest array
            updateInterestArray(interestNumber: 7, buttonStatus: specialIsPressed)
            
        }

    }
    
    
    @IBAction func startButton(_ sender: Any) {
        
        //use UpdateChildValues to submit interests to database
        
        let interest = DB()
        
        //let description = "nadav"
        
        //interest.updateInterests(arrayofInterests: interestsArray, description: description)
        
        interest.updateInterests(arrayofInterests: interestsArray)
        
        
        
        
        // segue to tabbed controller to complete setup process
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbed")
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
