//
//  ViewController.swift
//  NewsAPP
//
//  Created by PLWEP on 27/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    var newsData : [Article]? {
        didSet {
            DispatchQueue.main.async { [self] in
                newsTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsManager = NewsManager()
        newsManager.fetchNews { result in
            self.newsData = result.articles
        }
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return newsData?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "newsCell",
            for: indexPath
        ) as? NewsTableViewCell {
            guard let news = newsData?[indexPath.row] else {return UITableViewCell()}
            cell.newsTitleLabel.text = news.title
            cell.newsAuthorLabel.text = news.author
            cell.newsImageView.loadRemoteImageFrom(urlString: news.urlToImage ?? "")
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}


let imageCache = NSCache<AnyObject, AnyObject>()
let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
extension UIImageView {
  func loadRemoteImageFrom(urlString: String){
    let url = URL(string: urlString)
    image = nil
    activityView.center = self.center
    self.addSubview(activityView)
    activityView.startAnimating()
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
        self.image = imageFromCache
        activityView.stopAnimating()
        activityView.removeFromSuperview()
        return
    }
    URLSession.shared.dataTask(with: url!) {
        data, response, error in
        DispatchQueue.main.async {
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        }
          if let response = data {
              DispatchQueue.main.async {
                if let imageToCache = UIImage(data: response) {
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }else{
                    self.image = UIImage(named: "no image")
                }
              }
          }
     }.resume()
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
      performSegue(withIdentifier: "moveToDetail", sender: newsData?[indexPath.row])
  }
  override func prepare(
    for segue: UIStoryboardSegue,
    sender: Any?
  ) {
    if segue.identifier == "moveToDetail" {
      if let detaiViewController = segue.destination as? DetailViewController {
          detaiViewController.article = sender as? Article
      }
    }
  }
}



