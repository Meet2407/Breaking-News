//
//  NewWebUrlViewController.swift
//  Breaking News
//
//  Created by Meet Kapadiya on 04/09/24.
//

import UIKit
import WebKit
import CoreData

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var favroteBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    var urlString: String?
    var article: Article?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func favroteBtnTapped(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let article = article else { return }
        
        let newNewsData = NSEntityDescription.insertNewObject(forEntityName: "NewsData", into: context) as! NewsData
        newNewsData.title = article.title ?? ""
        newNewsData.decrision = article.description ?? ""
        
        do {
            try context.save()
        } catch {
            print("Failed to save the article: \(error)")
        }
        
    }
}
