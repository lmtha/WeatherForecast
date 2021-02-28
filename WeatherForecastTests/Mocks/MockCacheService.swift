//
//  MockCacheService.swift
//  WeatherForecastTests
//
//  Created by Tha Le on 2/28/21.
//

import Foundation
@testable import WeatherForecast

class MockCacheService: CacheService {
    var cache: [String: Codable] = [:]
    
    func setObject<T>(_ object: T, forKey key: String) where T : Codable {
        cache[key] = object
    }
    
    func object<T>(forKey key: String, as: T.Type, completion: @escaping (T?) -> ()) where T : Codable {
        guard let object = cache[key], let typedObject = object as? T else {
            completion(nil)
            return
        }
        
        completion(typedObject)
    }
}
