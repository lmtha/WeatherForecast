//
//  WeatherForecastPresenter.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/26/21.
//

import Foundation

protocol WeatherForecastViewProtocol: class {
    func showWeatherForecastData(_ data: [WeatherForecastItem])
    func showError(_ errorMsg: String)
}

class WeatherForecastPresenter {
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
        cacheService.object(forKey: key, as: [WeatherForecastItem].self) { [weak self] result in
            guard let self = self else {
                return
            }
            if let result = result {
                DispatchQueue.main.async {
                    self.view?.showWeatherForecastData(result)
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
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self?.cacheService.setObject(response.listItems, forKey: key)
                    self?.view?.showWeatherForecastData(response.listItems)
                    
                case let .failure(error):
                    self?.error = error
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }
}

