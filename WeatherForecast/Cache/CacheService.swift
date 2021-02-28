//
//  CacheService.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/27/21.
//

import Foundation
import PINCache

protocol CacheService {
    func setObject<T: Codable>(_ object: T, forKey key: String)
    func object<T: Codable>(forKey key: String, as: T.Type, completion: @escaping (T?) -> ())
}

class WeatherForecastCache: CacheService {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func setObject<T>(_ object: T, forKey key: String) where T : Codable {
        let data = try! encoder.encode(object)
        PINCache.shared.memoryCache.setTtl(true)
        PINCache.shared.diskCache.setTtl(true)
        PINCache.shared.setObject(data, forKey: key, withAgeLimit: 36)
    }
    
    func object<T>(forKey key: String, as: T.Type, completion: @escaping (T?) -> ()) where T : Codable {
        PINCache.shared.object(forKeyAsync: key) { [weak self] cache, key, data in
            guard let self = self, let jsonData = data as? Data else {
                completion(nil)
                return
            }
            
            let object = try? self.decoder.decode(T.self, from: jsonData)
            completion(object)
        }
    }
}
