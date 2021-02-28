//
//  ProviderType.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/27/21.
//

import Foundation
import Moya

public protocol ProviderType {
    func request<ObjectType: Codable, TargetService: TargetType>(
        _ target: TargetService,
        type: ObjectType.Type,
        completion: @escaping (_ result: Result<ObjectType, Error>) -> Void
    )
}
