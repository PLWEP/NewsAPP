//
//  DetailViewController.swift
//  NewsAPP
//
//  Created by PLWEP on 27/03/23.
//

import UIKit

class DetailViewController: UIViewController {


    
    @IBOutlet weak var newsDescLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    var article : Article? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = article {
            newsTitleLabel.text = result.title ?? "Title"
            newsAuthorLabel.text = result.author ?? "Author"
            newsDescLabel.text = result.description ?? "Desc"
            newsImageView.loadRemoteImageFrom(urlString: result.urlToImage ?? "")
        }
    }
}
