//
//  ProfileViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/24/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var stats: UILabel!
    @IBOutlet weak var sustainableScore: UIImageView!
    
    @IBOutlet weak var numberOfFollowers: UILabel!
    @IBOutlet weak var numberOfFollowing: UILabel!
    @IBOutlet weak var numberOfEvents: UILabel!
    
    @IBAction func settingsButton(_ sender: Any) {
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
