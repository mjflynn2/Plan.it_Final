//
//  MyEventsTableViewCell.swift
//  plan.it
//
//  Created by Daniel Silva on 5/11/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit

class MyEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var leafImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
