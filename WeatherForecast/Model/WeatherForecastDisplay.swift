//
//  WeatherForecastDisplay.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/28/21.
//

import Foundation

class WeatherForecastDisplay {
    init(formattedDescription: String, formattedPressure: String, formattedHumidity: String, formattedAverageTemp: String, formattedDate: String) {
        self.formattedDescription = formattedDescription
        self.formattedPressure = formattedPressure
        self.formattedHumidity = formattedHumidity
        self.formattedAverageTemp = formattedAverageTemp
        self.formattedDate = formattedDate
    }
    
    
    let formattedDescription: String
    let formattedPressure: String
    let formattedHumidity: String
    let formattedAverageTemp: String
    let formattedDate: String
}
