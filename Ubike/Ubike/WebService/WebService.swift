//
//  WebService.swift
//  Ubike
//
//  Created by kidnapper on 2019/11/24.
//  Copyright © 2019 kidnapper. All rights reserved.
//

import Foundation

enum ErrorType: Error {
    case invalidUrl
}

enum ApiResult {
    case success(UbikeModel)
    case failure(Error?)
}

final class WebService {
    
    static let shared: WebService = WebService()
    
    private init() {}
    
    func getTaipeiUbikeData(completion: @escaping (ApiResult) -> Void) throws {
        guard let url: URL = URL(string: "https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.gz") else {
            throw ErrorType.invalidUrl
        }
        let session: URLSession = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, apiError) in
            guard let apiData: Data = data else {
                completion(.failure(apiError))
                return
            }
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let model: UbikeModel = try decoder.decode(UbikeModel.self, from: apiData)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
