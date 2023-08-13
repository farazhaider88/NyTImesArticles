//
//  ArticleViewModel.swift
//  NyTimesMostPopularArticles
//
//  Created by Syed Faraz Haider Zaidi on 13/08/2023.
//

import Foundation
import Combine


class ArticleViewModel: ObservableObject {
    
    private let networking: NetworkingProtocol
        
    
    @Published var articles: [Article]? = []
    @Published var error: Error?
    @Published var isInternetAvailable = true
   
    private var cancellables = Set<AnyCancellable>()
    private let checker = InternetConnectivityChecker()
    
    
    init(networking: NetworkingProtocol) {
          self.networking = networking
      }
    
    func fetchData() {
        checker.checkInternetConnectivity { isConnected in
            if isConnected {
                let url = "\(APIConstants.baseUrl)\(APIConstants.most_popular_url)7.json"
                
                guard var components = URLComponents(string: url) else {
                    print("Error: cannot create URLCompontents")
                    return
                }
                components.queryItems = [URLQueryItem(name: "api-key", value: APIConstants.api_key)]
                
                guard let url = components.url else {
                    print("Error: in URL")
                    return
                }
                
                self.networking.fetchData(from: url)
                    .sink { [weak self] completion in
                        switch completion {
                        case .finished:
                            // Handle successful completion
                            break
                        case .failure(let error):
                            // Handle error
                            self?.error = error
                        }
                    } receiveValue: { [weak self] (response: ArticleResponse) in
                        self?.articles = response.articles
                    }
                    .store(in: &self.cancellables)
                
            } else {
                self.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "No Internet Available"])
            }
        }
        
        
        
    }
}
