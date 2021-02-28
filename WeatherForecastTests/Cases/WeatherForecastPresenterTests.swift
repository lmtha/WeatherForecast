//
//  WeatherForecastPresenterTests.swift
//  WeatherForecastTests
//
//  Created by Tha Le on 2/27/21.
//

import XCTest
@testable import WeatherForecast

class WeatherForecastPresenterTests: XCTestCase {

    var sut: WeatherForecastPresenter!
    var mockProvider: MockProvider!
    var mockView: MockView!
    var mockCache: MockCacheService!
    
    override func setUp() {
        super.setUp()
        mockProvider = MockProvider()
        mockCache = MockCacheService()
        sut = WeatherForecastPresenter(provider: mockProvider, cacheService: mockCache)
        mockView = MockView(presenter: sut)
        sut.view = mockView
    }
    
    override func tearDown() {
        sut = nil
        mockProvider = nil
        mockView = nil
        super.tearDown()
    }
    
    func test_searchWeatherForecast_haveData() {
        //given
        let data = mockJSONData().data(using: .utf8)!
        let decoder = JSONDecoder()
        let expectedEvents = try! decoder.decode(WeatherForecastInfo.self, from: data)
        mockProvider.mockResponse = MockResponse(result: .success(expectedEvents))
        
        //when
        sut.searchWeatherForecast(filterBy: "Saigon")
        let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
            return !(vc as! MockView).weatherData.isEmpty
        }), evaluatedWith: mockView, handler: nil)

        //then
        wait(for: [exp], timeout: 3)
        XCTAssertEqual(mockView.weatherData.count, 7)
        XCTAssertFalse(mockView.hasError)
        
        let item = mockView.weatherData[0]
        XCTAssertEqual(item.formattedDate, "Date: Sat, 27 Feb 2021")
        XCTAssertEqual(item.formattedHumidity, "Humidity: 39%")
        XCTAssertEqual(item.formattedPressure, "Pressure: 1008")
        XCTAssertEqual(item.formattedDescription, "Description: sky is clear")
        XCTAssertEqual(item.formattedAverageTemp, "Average Temperature: 29ºC")
    }

    func test_searchWeatherForecast_noData() {
        //given
        let jsonData = """
            {
                "cod": "404",
                "message": "city not found"
            }

        """
        let data = jsonData.data(using: .utf8)!
        let decoder = JSONDecoder()
        let expectedError = try! decoder.decode(ResponseError.self, from: data)
        mockProvider.mockResponse = MockResponse(result: .failure(expectedError))
        
        //when
        sut.searchWeatherForecast(filterBy: "Foo")
        let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
            return (vc as! MockView).hasError
        }), evaluatedWith: mockView, handler: nil)

        //then
        wait(for: [exp], timeout: 3)
        XCTAssertEqual(mockView.weatherData.count, 0)
        XCTAssertTrue(mockView.hasError)
        XCTAssertTrue(sut.error?.localizedDescription == expectedError.localizedDescription)
    }
    
    func test_searchWeatherForecast_givenData_cachesData() {
        //given
        let data = mockJSONData().data(using: .utf8)!
        let decoder = JSONDecoder()
        let expectedEvents = try! decoder.decode(WeatherForecastInfo.self, from: data)
        mockProvider.mockResponse = MockResponse(result: .success(expectedEvents))
        
        //when
        sut.searchWeatherForecast(filterBy: "Saigon")
        let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
            return !(vc as! MockView).weatherData.isEmpty
        }), evaluatedWith: mockView, handler: nil)

        //then
        wait(for: [exp], timeout: 3)
        XCTAssertNotNil(mockCache.cache["Saigon"])
        XCTAssertTrue((mockCache.cache["Saigon"] as AnyObject) is [WeatherForecastItem])
        XCTAssertEqual(mockView.weatherData.count, 7)
    }
}
