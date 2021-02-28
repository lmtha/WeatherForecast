import UIKit
import SafariServices

final class Navigator {
    static let shared = Navigator()
    
    private init() {}
    
    private let navigationVC = MainNavigationViewController()
  
    lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .black
        window.rootViewController = self.navigationVC
        return window
    }()
    
    func showWeatherForecastScreen() {
        let provider = NetworkProvider()
        let presenter = WeatherForecastPresenter(provider: provider, cacheService: WeatherForecastCache())
        let weatherForecastVC = WeatherForecastViewController(presenter: presenter)
        presenter.view = weatherForecastVC

        navigationVC.setViewControllers([weatherForecastVC], animated: true)
    }
}
