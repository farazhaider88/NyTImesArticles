//
//  Networking.swift
//  NyTimesMostPopularArticles
//
//  Created by Syed Faraz Haider Zaidi on 13/08/2023.
//

import Foundation
import Combine

protocol NetworkingProtocol {
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Networking.NetworkingError>
}

extension Networking: NetworkingProtocol {}


class Networking {
    enum NetworkingError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidResponse
        case decodingFailed(Error)
    }
    
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, NetworkingError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkingError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkingError in
                if let decodingError = error as? DecodingError {
                    return NetworkingError.decodingFailed(decodingError)
                } else {
                    return NetworkingError.requestFailed(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
