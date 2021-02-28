//
//  WeatherForecastPresenter.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/26/21.
//

import Foundation

protocol WeatherForecastViewProtocol: class {
    func showWeatherForecastData(_ data: [WeatherForecastDisplay])
    func showError(_ errorMsg: String)
}

protocol WeatherForecastPresenterProtocol {
    func searchWeatherForecast(filterBy name: String)
}

class WeatherForecastPresenter: WeatherForecastPresenterProtocol {
    weak var view : WeatherForecastViewProtocol?
    private let provider: ProviderType
    private let cacheService: CacheService
    var error: Error?

    init(provider: ProviderType, cacheService: CacheService) {
        self.provider = provider
        self.cacheService = cacheService
    }
    
    func searchWeatherForecast(filterBy name: String) {
        self.retrieveDataFromCache(name)
    }
    
    private func retrieveDataFromCache(_ key: String) {
        cacheService.object(forKey: key, as: WeatherForecastInfo.self) { [weak self] result in
            guard let self = self else {
                return
            }
            if let result = result,
               let expiryTime = result.expiryTime,
               expiryTime > Date().timeIntervalSince1970 {
                DispatchQueue.main.async {
                    let formattedWeatherData = result.listItems.map(self.mappingData(_:))
                    self.view?.showWeatherForecastData(formattedWeatherData)
                }
                return
            }

            self.retrieveDataFromAPI(key)
        }
    }
    
    private func retrieveDataFromAPI(_ key: String) {
        self.provider.request(
            WeatherForecastService.searchWeatherForecastData(filterBy: key),
            type: WeatherForecastInfo.self
        ) { [weak self] result in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    response.expiryTime = Date().timeIntervalSince1970 + 3600
                    self.cacheService.setObject(response, forKey: key)
                    
                    let formattedWeatherData = response.listItems.map(self.mappingData(_:))
                    self.view?.showWeatherForecastData(formattedWeatherData)
                    
                case let .failure(error):
                    self.error = error
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    private func mappingData(_ data: WeatherForecastItem) -> WeatherForecastDisplay {
        let timeStr = DateFormatterHelper.stringForDateInterval(
            timeIntervalSince1970: data.dateInterval,
            format: "EEE, dd MMM yyyy",
            timeIntervalType: .seconds
        )
        let formattedDate = String(format: ConstantString.formatDateLbl, timeStr)
        let averageTemp = Int(((data.temperature.max + data.temperature.min) / 2.0).rounded(.toNearestOrEven))
        let formattedAverageTemp = String(format: ConstantString.formatAvgTempLbl, averageTemp)
        let formattedPressure = String(format: ConstantString.formatPressureLbl, data.pressure)
        let formattedHumidity = String(format: ConstantString.formatHumidityLbl, data.humidity)
        let description = data.weatherItems.compactMap({ $0.description }).joined(separator: ", ")
        let formattedDescription = String(format: ConstantString.formatDescriptionLbl, description)

        return WeatherForecastDisplay(formattedDescription: formattedDescription, formattedPressure: formattedPressure, formattedHumidity: formattedHumidity, formattedAverageTemp: formattedAverageTemp, formattedDate: formattedDate)
    }
}

