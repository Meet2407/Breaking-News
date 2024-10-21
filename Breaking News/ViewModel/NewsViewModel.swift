//
//  ViewModel.swift
//  Breaking News
//
//  Created by Meet Kapadiya on 30/08/24.
//

import Foundation
import Alamofire

class NewsViewModel {
    
    var arrNews: NewsModel?
    
    func fechUser(success: @escaping (Data) -> (Void), failure: @escaping (Error) -> (Void)){
        let url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c9c95f7d35e641d68f5e560953895b60"
        AF.request(url).responseData { responce in
            switch responce.result{
            case .success(let data):
                do{
                    let decoder = JSONDecoder()
                    let responceData = try decoder.decode(NewsModel.self, from: data)
                    self.arrNews = responceData
                    success(data)
                }catch{
                    failure(error)
                }
            case .failure(let error):
                print("error")
                failure(error)
            }
        }
    }
    
}
