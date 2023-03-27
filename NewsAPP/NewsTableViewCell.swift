//
//  NewsTableViewCell.swift
//  NewsAPP
//
//  Created by PLWEP on 27/03/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
