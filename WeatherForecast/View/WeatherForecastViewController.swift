//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/25/21.
//

import UIKit
import SnapKit

final class WeatherForecastViewController: UIViewController {
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let errorLabel = UILabel()
    
    private let presenter: WeatherForecastPresenter
    var weatherData: [WeatherForecastItem] = []
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
      var recognizer = UITapGestureRecognizer(target:self, action: #selector(WeatherForecastViewController.dismissKeyboard))
      return recognizer
    }()
    
    init(presenter: WeatherForecastPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public var prefersStatusBarHidden: Bool {
        false
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        let mainView = UIView()
        
        mainView.addSubview(searchBar)
        mainView.addSubview(tableView)
        mainView.addSubview(errorLabel)
        
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      
        tableView.contentInset = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: keyboardSize.height,
                                              right: 0)
    }
    
    
    @objc func dismissKeyboard() {
      searchBar.resignFirstResponder()
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        tableView.contentInset = UIEdgeInsets.zero
    }
    
    private func setupConstraint() {
        self.searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        self.errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func visualize() {
        title = "Weather Forecast"
        
        errorLabel.font = UIFont.boldSystemFont(ofSize: 30)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center

        searchBar.placeholder = "Search City"
        searchBar.delegate = self
        
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 10,
                                                bottom: 0,
                                                right: 0)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = false
        tableView.dataSource = self
        tableView.register(cellType: WeatherForecastDetailCell.self)
    }

    var searchTimer: Timer?
}

extension WeatherForecastViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTimer?.invalidate()
        
        guard searchText.count > 2 else { return }
        let city = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        searchTimer = Timer.scheduledTimer(
            withTimeInterval: 0.3,
            repeats: false,
            block: { [weak self] timer in
                self?.presenter.searchWeatherForecast(filterBy: city)
            }
        )
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      view.removeGestureRecognizer(tapRecognizer)
    }
}

extension WeatherForecastViewController: WeatherForecastViewProtocol {
    func showWeatherForecastData(_ data: [WeatherForecastItem]) {
        self.weatherData = data
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.errorLabel.isHidden = true
    }
    
    func showError(_ errorMsg: String) {
        self.weatherData = []
        self.tableView.isHidden = true
        self.errorLabel.isHidden = false

        self.tableView.reloadData()
        errorLabel.text = errorMsg
    }
}

extension WeatherForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WeatherForecastDetailCell.self)
        cell.setWeatherForecastData(weatherData[indexPath.row])
        return cell
    }
}
