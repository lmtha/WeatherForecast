//
//  Target.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/27/21.
//

import Foundation
import Moya

struct Target: TargetType {
    private let target: TargetType

    var baseURL: URL {
        target.baseURL
    }

    var path: String {
        target.path
    }

    var method: Moya.Method {
        target.method
    }

    var sampleData: Data {
        target.sampleData
    }

    var task: Task {
        target.task
    }

    var headers: [String: String]? {
        target.headers
    }


    init(target: TargetType) {
        self.target = target
    }
}
