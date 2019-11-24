//
//  UbikeRepository.swift
//  Ubike
//
//  Created by kidnapper on 2019/11/24.
//  Copyright © 2019 kidnapper. All rights reserved.
//

import Foundation

final class UbikeRepository {
    
    static let shared: UbikeRepository = UbikeRepository()
    
    private init() {}
    
    func fetchData(successCompletion: @escaping (UbikeModel) -> Void, failCompletion: @escaping (Error?) -> Void) {
        do {
            try WebService.shared.getTaipeiUbikeData { result in
                switch result {
                case let .success(ubikeModel):
                    successCompletion(ubikeModel)
                case let .failure(error):
                    failCompletion(error)
                }
            }
        } catch {
            assertionFailure("getTaipeiUbikeData failed")
        }
    }
    
}
