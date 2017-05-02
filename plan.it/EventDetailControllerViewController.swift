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

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventPrice: UILabel!
    // when I change eventPrice I need to add $ before the amount
    @IBOutlet weak var eventRSVPs: UILabel!
    
    @IBAction func rsvpButton(_ sender: Any) {
        
        // will take event key and add it to the array of rsvp events
        
        // also add 10 points to sustainability score
        
        // create alert that confirmed that the you have successfully rsvp'd to the event
    }
    
    @IBAction func inviteButton(_ sender: Any) {
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
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
