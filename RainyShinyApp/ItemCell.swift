//
//  WeatherCell.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 23.02.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var MinTempLabel: UILabel!
    

    func configureCell(forecast: ForeCast) {
        
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        maxTempLabel.text = String(format: "%.1f",forecast.highTemp) + "°"
        MinTempLabel.text = String(format: "%.1f",forecast.lowTemp) + "°"
        
        
    }

}
