//
//  ViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 3/25/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import QuartzCore




class SignInViewController: UIViewController, UITextFieldDelegate {
    
    //constant
    let loginToList = "LoginToList"
    
    //let rootRef = FIRDatabase.database().reference()

    //Text Fields
    
//    @IBOutlet var step: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    //Buttons
    @IBAction func logInButton(_ sender: Any) {
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        
        if emailText.text == "" || passwordText.text == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()!.createUser(withEmail: emailText.text!,
                                       password: passwordText.text!) { user, error in
                if error == nil {
                    
                    print("created user successfully")
                    
                    
                    
                    /*
                    let alertController = UIAlertController(title: "Success", message: "Welcome to your new plan.it account!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Set up Interests", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    */
                    
                    // adding the new users to the database
                    let interestsArray: [Bool] = [false, false, false, false, false, false, false, false]
                    
                    let emptyRSVPArray: [String] = ["eventKeyDummy"]
                    
                    let newUser = DB()
                    newUser.insertNewUser(email: self.emailText.text!, description: "", rsvps: emptyRSVPArray, favorites: "", followers: "", following: "", image: "", interests: interestsArray, firstName: self.firstName.text!, lastName: self.lastName.text!, notifications: "", sustainabilityScore: 10, type: 0)
                    
                    
                    
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Interests")
                    self.present(vc!, animated: true, completion: nil)
                    
                    /*
                    FIRAuth.auth()!.signIn(withEmail: self.emailText.text!,
                                            password: self.passwordText.text!)
                    }
                    */
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                                        
            }
            
            
            
            
        }
        /*
        
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
            
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
                                        
            FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                        password: passwordField.text!) { user, error in
                    if error == nil {
                        
                        FIRAuth.auth()!.signIn(withEmail: self.emailLogIn.text!,
                                                password: self.passwordLogIn.text!)
                    }
            }
                                        
                                        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
 
        */
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 1
        /*
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                self.performSegue(withIdentifier: "Interests", sender: nil)
            }
        }
        */
        
        //FIRApp.configure()
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



}

