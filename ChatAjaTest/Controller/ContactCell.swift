//
//  ContactCell.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 05/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var outletImage: UIImageView!
    @IBOutlet weak var outletName: UILabel!
    @IBOutlet weak var outletStatus: UILabel!
    
    var profile: Profile?{
        didSet{
            
            if let imageURL = profile?.profileImage{
                outletImage.sd_setImage(with: URL(string: imageURL)!, completed: nil)
            }
            
            if let name = profile?.name{
                outletName.text = name
            }
            
            outletStatus.text = "ready"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outletImage.layer.cornerRadius = outletImage.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
