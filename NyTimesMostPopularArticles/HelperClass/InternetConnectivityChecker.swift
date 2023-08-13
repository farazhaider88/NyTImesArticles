//
//  InternetConnectivityChecker.swift
//  NyTimesMostPopularArticles
//
//  Created by Syed Faraz Haider Zaidi on 13/08/2023.
//

import Foundation
class InternetConnectivityChecker {
    
    func checkInternetConnectivity(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://www.apple.com") else {
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
        
        task.resume()
    }
}
