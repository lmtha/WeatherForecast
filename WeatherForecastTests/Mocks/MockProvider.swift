//
//  MockProvider.swift
//  WeatherForecastTests
//
//  Created by Tha Le on 2/27/21.
//

@testable import WeatherForecast
import Foundation
import Moya

class MockProvider: ProviderType {
    var mockResponse: MockResponse!
    
    func request<ObjectType, TargetService>(
        _ target: TargetService,
        type: ObjectType.Type,
        completion: @escaping (Result<ObjectType, Error>) -> Void
    ) where ObjectType : Codable, TargetService : TargetType {
        switch self.mockResponse.result {
        case .success(let mockObject):
            guard let object = mockObject as? ObjectType else {
                fatalError("Unexpected response: \(mockObject.self), expecting: \(ObjectType.self)")
            }
            completion(.success(object))
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
