//
//  LogInViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 3/28/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LogInViewController: UIViewController {

    @IBOutlet weak var emailEntered: UITextField!
    @IBOutlet weak var passwordEntered: UITextField!
    
//    @IBOutlet var step: UILabel!
    
    @IBAction func logInPressed(_ sender: Any) {
        
        if self.emailEntered.text == "" || self.passwordEntered.text == "" {
            
            // alert telling them that they haven't entered email and password corect
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.emailEntered.text!, password: self.passwordEntered.text!) { (user, error) in
                
                if error == nil {
                    
                    // log in successful
                    
                    // go to Events tab
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbed")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                } else {
                    
                    // alert that there is a login error
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }
            
            }
        }
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
