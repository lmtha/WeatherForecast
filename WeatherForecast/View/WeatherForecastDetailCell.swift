//
//  WeatherForecastDetailCell.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/26/21.
//

import UIKit
import SnapKit

class WeatherForecastDetailCell: UITableViewCell, Reusable {
    private let dateLabel = UILabel()
    private let averageTempLabel = UILabel()
    private let pressureLabel = UILabel()
    private let humidityLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        visualize()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(averageTempLabel)
        contentView.addSubview(pressureLabel)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func visualize() {
        contentView.backgroundColor = .lightGray
        
        [dateLabel, averageTempLabel, pressureLabel, humidityLabel, descriptionLabel].forEach { label in
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.7
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
        }
        
        descriptionLabel.numberOfLines = 0
    }
    
    func setupLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        averageTempLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(dateLabel)
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.top.equalTo(averageTempLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(dateLabel)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(pressureLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(dateLabel)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(dateLabel)
            make.bottom.equalToSuperview().offset(-14)
        }
    }

    
    func setWeatherForecastData(_ data: WeatherForecastDisplay) {
        dateLabel.text = data.formattedDate
        averageTempLabel.text = data.formattedAverageTemp
        pressureLabel.text = data.formattedPressure
        humidityLabel.text = data.formattedHumidity
        descriptionLabel.text = data.formattedDescription
    }
}
