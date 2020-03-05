//
//  ChatCell.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 05/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatCell: UITableViewCell {
    @IBOutlet weak var outletMessage: UILabel!
    @IBOutlet weak var outletName: UILabel!
    @IBOutlet weak var outletDate: UILabel!
    var message: Message?{
        didSet{
            outletName.text = message?.name
            
            let timeDate = NSDate(timeIntervalSince1970: (Double(message!.time!)!))
            let dateFormated = DateFormatter()
            dateFormated.dateFormat = "hh:mm:ss: a"
            outletDate.text = dateFormated.string(from: timeDate as Date)
            
            outletMessage?.text = message?.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
