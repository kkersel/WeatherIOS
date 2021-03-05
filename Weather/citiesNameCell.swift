//
//  citiesNameCell.swift
//  weather4.0
//
//  
//

import UIKit

class citiesNameCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var citytemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
