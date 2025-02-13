//
//  ContactsTableViewCell.swift
//  Challenge_MSN
//
//  Created by Amanda Baião on 11/02/25.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var statusLabelView: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var dailyMessageLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func statusLabelViewConfig(status: String) {
        switch status {
        case "Disponível":
            statusImageView.image = UIImage(named: "iconMSNonline")
        case "Ausente":
            statusImageView.image = UIImage(named: "iconMSNbusy")
        case "Ocupado":
            statusImageView.image = UIImage(named: "iconMSNdonotdisturb")
        case "Offline":
            statusImageView.image = UIImage(named: "iconMSNoffline")
        default:
            break
        }
        
    }
    
}



