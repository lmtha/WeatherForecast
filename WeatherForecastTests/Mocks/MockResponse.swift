//
//  MockResponse.swift
//  WeatherForecastTests
//
//  Created by Tha Le on 2/27/21.
//

import Foundation

public struct MockResponse {
    public typealias Result = Swift.Result<Codable, Error>
    
    public let result: Result
    public let delayTime: DispatchTimeInterval
    
    public init(result: MockResponse.Result, delayTime: DispatchTimeInterval = .nanoseconds(0)) {
        self.result = result
        self.delayTime = delayTime
    }
}

func mockJSONData() -> String {
    let json = """
    {
    "cnt": 7,
    "list": [
    {
      "dt": 1614402000,
      "temp": {
        "day": 34.97,
        "min": 22.59,
        "max": 36.23,
        "night": 24.23,
        "eve": 30.5,
        "morn": 22.59
      },
      "pressure": 1008,
      "humidity": 39,
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "sky is clear",
          "icon": "01d"
        }
      ]
    },
    {
      "dt": 1614488400,
      "temp": {
        "day": 35.72,
        "min": 23.81,
        "max": 36.57,
        "night": 26.11,
        "eve": 29.56,
        "morn": 23.82
      },

      "pressure": 1010,
      "humidity": 33,
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "sky is clear",
          "icon": "01d"
        }
      ]
    },
    {
      "dt": 1614574800,

      "temp": {
        "day": 36.2,
        "min": 24.61,
        "max": 36.2,
        "night": 25.99,
        "eve": 27.6,
        "morn": 24.61
      },

      "pressure": 1010,
      "humidity": 34,
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "broken clouds",
          "icon": "04d"
        }
      ]
    },
    {
      "dt": 1614661200,
      "temp": {
        "day": 37.03,
        "min": 24.03,
        "max": 37.03,
        "night": 25.88,
        "eve": 26.94,
        "morn": 24.62
      },

      "pressure": 1010,
      "humidity": 32,
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d"
        }
      ]
    },
    {
      "dt": 1614747600,

      "temp": {
        "day": 37.22,
        "min": 24.79,
        "max": 37.22,
        "night": 27.68,
        "eve": 28.68,
        "morn": 24.85
      },

      "pressure": 1009,
      "humidity": 29,
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "sky is clear",
          "icon": "01d"
        }
      ]
    },
    {
      "dt": 1614834000,

      "temp": {
        "day": 37.41,
        "min": 25.48,
        "max": 37.41,
        "night": 26.46,
        "eve": 28.43,
        "morn": 25.48
      },

      "pressure": 1009,
      "humidity": 24,
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "sky is clear",
          "icon": "01d"
        }
      ]
    },
    {
      "dt": 1614920400,

      "temp": {
        "day": 37.78,
        "min": 24.41,
        "max": 37.78,
        "night": 25.11,
        "eve": 26.26,
        "morn": 24.59
      },

      "pressure": 1010,
      "humidity": 22,
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "sky is clear",
          "icon": "01d"
        }
      ]
    }
    ]
    }
    """
    
    return json
}
