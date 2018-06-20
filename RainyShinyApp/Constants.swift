//
//  Constants.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 20.02.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import Foundation



let API_KEY = "0f5eff124be6750ae10859b8b0669130"


typealias DownloadComplete = () -> ()


let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(API_KEY)"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=\(API_KEY)"
