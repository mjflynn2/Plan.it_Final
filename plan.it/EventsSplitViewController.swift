//
//  EventsSplitViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/18/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit

class EventsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {


        
        override func viewDidLoad() {
            self.delegate = self
            self.preferredDisplayMode = .allVisible
        }
        
        func splitViewController(
            _ splitViewController: UISplitViewController,
            collapseSecondary secondaryViewController: UIViewController,
            onto primaryViewController: UIViewController) -> Bool {
            // Return true to prevent UIKit from applying its default behavior
            return true
        }
    
}
