//
//  Response.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/26/21.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let data: T?
    let error: ResponseError?
        
    enum ResponseKeys: String, CodingKey {
        case code = "cod"
    }
    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseKeys.self)
        let code = try container.decode(String.self, forKey: .code)
        
        if code != "200" {
            self.error = try ResponseError(from: decoder)
            self.data = nil
            return
        }
        
        self.data = try T.init(from: decoder)
        self.error = nil
    }
}
