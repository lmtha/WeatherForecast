//
//  MockView.swift
//  WeatherForecastTests
//
//  Created by Tha Le on 2/27/21.
//

import Foundation
@testable import WeatherForecast

class MockView: WeatherForecastViewProtocol {
    var weatherData: [WeatherForecastItem] = []
    var hasError: Bool = false
    var presenter: WeatherForecastPresenter
    
    init(presenter: WeatherForecastPresenter) {
        self.presenter = presenter
    }
    
    func showWeatherForecastData(_ data: [WeatherForecastItem]) {
        self.weatherData = data
    }
    
    func showError(_ errorMsg: String) {
        self.hasError = true
    }
    
    func searchWeatherData(_ name: String) {
        self.presenter.searchWeatherForecast(filterBy: name)
    }
}
