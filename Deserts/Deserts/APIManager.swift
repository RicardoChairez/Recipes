//
//  APIManager.swift
//  Deserts
//
//  Created by Chip Chairez on 2/17/25.
//

import Foundation

typealias ResultHandler<T> = (Result<T, NetworkError>) -> Void

final class APIManager {
    static let shared = APIManager()
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    
    private init(networkHandler: NetworkHandler = NetworkHandler(),
             responseHandler: ResponseHandler = ResponseHandler()) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    func request<T: Codable>(
        modelType: T.Type,
        url: URL?,
        completion: @escaping ResultHandler<T>
    ) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        networkHandler.requestDataAPI(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                self.responseHandler.parseResponseDecode(data: data, modelType: modelType) { response in
                    switch response {
                    case .success(let mainResponse):
                        completion(.success(mainResponse))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImageDataURL(url: URL?, completion: @escaping (Result<URL, NetworkError>) -> Void){
        guard let url = url else {return}
        let urlRequest = URLRequest(url: url)
        networkHandler.requestDataAPI(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                guard let imageDataURL = URL(string: "data:image/jpeg;base64," + data.base64EncodedString()) else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(imageDataURL))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
    case serverError
}
