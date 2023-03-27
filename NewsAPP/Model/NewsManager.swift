//
//  NewsManager.swift
//  NewsAPP
//
//  Created by PLWEP on 27/03/23.
//

import UIKit

struct NewsManager {
    func fetchNews(completion: @escaping(APIResult) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=a319ce3613244cbb8a5fbde15606848b") else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error fetching \(error.localizedDescription)")
            }

            guard let jsonData = data else { return }
            let decoder = JSONDecoder()

            do {
                let decodedData = try decoder.decode(APIResult.self, from: jsonData)
                completion(decodedData)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        
        dataTask.resume()
    }
}

