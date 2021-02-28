//
//  WeatherForecastService.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/27/21.
//

import Foundation
import Moya

enum WeatherForecastService: TargetType {
    case searchWeatherForecastData(filterBy: String)
    
    var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/2.5")!
    }
    
    var path: String {
        switch self {
        case .searchWeatherForecastData:
            return "forecast/daily"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .searchWeatherForecastData(filterByName):
            return [
                "q": filterByName,
                "cnt": 7,
                "appid": "60c6fbeb4b93ac653c492ba806fc346d",
                "units": "metric"
            ]
        }
    }
    
    var task: Task {
        guard let parameters = parameters else {
            return .requestPlain
        }
        
        switch method {
        case .get:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        nil
    }
}
