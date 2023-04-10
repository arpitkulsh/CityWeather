//
//  CityTableViewCell.swift
//  CityWeather
//
//  Created by Arpit Kulshrestha on 05/04/23.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet var cityText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
