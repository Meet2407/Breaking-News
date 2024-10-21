//
//  ViewController.swift
//  Breaking News
//
//  Created by Meet Kapadiya on 30/08/24.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var news: UIView!
    @IBOutlet weak var newstbl: UITableView!
    var newsDetail = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        news.layer.cornerRadius = 20
        newstbl.dataSource = self
        newstbl.delegate = self
        getUser()
        print("hii")
    }

    func getUser(){
        newsDetail.fechUser{ _ in
            self.newstbl.reloadData()
        } failure: { error in
            print(error)
        }
    }
}

extension UIImageView {
    
    func downloadImage(from url: URL) {
        contentMode = .scaleToFill
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        dataTask.resume()
    }
}


extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDetail.arrNews?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.newstbl.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        let news = newsDetail.arrNews
        cell.newsOne.text = "\(news!.articles[indexPath.row].title)"
        cell.newsTwo.text = " \(news!.articles[indexPath.row].author)"
        cell.newsThree.text = "\(news!.articles[indexPath.row].description)"
          
        let urlToImage = news!.articles[indexPath.row].urlToImage
           
           // If it's non-optional (String), simply use the string to create the URL
           if let imageUrl = URL(string: urlToImage) {
               cell.newsImage.downloadImage(from: imageUrl)
           } else {
               // Set a placeholder image if the URL is invalid
               cell.newsImage.image = UIImage(named: "placeholder")
           }
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc!.urlString = newsDetail.arrNews?.articles[indexPath.row].url
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView",
           let webVC = segue.destination as? DetailViewController,
           let urlString = sender as? String {
            webVC.urlString = urlString
        }
    }
}
