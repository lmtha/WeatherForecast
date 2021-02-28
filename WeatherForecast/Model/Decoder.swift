//
//  Decoder.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/26/21.
//

import Foundation

public class Decoder {
    private let jsonDecoder = JSONDecoder()
    public init() {}
    
    func decodeEntity<ObjectType: Decodable>(type: ObjectType.Type, data: Data) -> Result<ObjectType, Error> {
        do {
            let response: Response<ObjectType> = try jsonDecoder.decode(Response.self, from: data)
            if let providerObject = response.data {
                return .success(providerObject)
            } else if let error = response.error {
                return .failure(error)
            } else {
                return .failure(NSError(domain: "NAB", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unknow error when decoding data"]))
            }
        } catch {
            return .failure(error)
        }
    }
}
