//
//  NetworkProvider.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/27/21.
//

import Foundation
import Moya

class NetworkProvider: ProviderType {
    private let decoder = Decoder()
    
    private lazy var moyaProvider: MoyaProvider<Target> = {
        return MoyaProvider<Target>(
            callbackQueue: DispatchQueue.global(qos: .background)
        )
    }()
    
    func request<ObjectType, TargetService>(
        _ target: TargetService,
        type: ObjectType.Type,
        completion: @escaping (Result<ObjectType, Error>) -> Void
    ) where ObjectType : Codable, TargetService : TargetType {
        
        let apiTarget = Target(target: target)
        
        moyaProvider.request(apiTarget, progress: nil) { result in
            switch result {
            case .success(let response):
                let result = self.decoder.decodeEntity(type: type, data: response.data)
                completion(result)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
