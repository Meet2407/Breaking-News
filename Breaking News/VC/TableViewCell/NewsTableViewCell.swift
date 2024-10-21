//
//  NewsTableViewCell.swift
//  Breaking News
//
//  Created by Meet Kapadiya on 30/08/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsOne: UILabel!
    @IBOutlet weak var newsTwo: UILabel!
    @IBOutlet weak var newsThree: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
