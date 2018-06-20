//
//  CurrentWeather.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 20.02.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit
import Alamofire


class CurrentWeather {
    
    
    var _cityName: String?
    var _date: String?
    var _weatherType: String?
    var _currentTemperature: Double?
    var _country: String?
    
    
    
    
    var country: String {
        
        if _country == nil {
            _country = ""
        }
        
        return _country!
        
        
    }
    
    
    
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName!
        
        
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType!
        
        
    }
    var currentTemperature: Double {
        if _currentTemperature == nil {
            _currentTemperature = 0.0
        }
        return _currentTemperature!
        
        
    }
    
    var date: String {
        if _date == nil {
            _date = ""
            
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date!
    
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        //Alomofire download
        let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=0f5eff124be6750ae10859b8b0669130"
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON {
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    
                    self._cityName = name.capitalized
                    
                }
                
                
                if let sys = dict["sys"] as? Dictionary<String, AnyObject>{
                    if let country = sys["country"] as? String {
                        self._country = country.uppercased()
                        
                    }
                    
                }

                
                
                
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        
                       
                        let kelvinToCelsius2 = currentTemp - 273.15
                        self._currentTemperature = kelvinToCelsius2
                        

                    
                }
            }
            
        }
        completed()
        }
    }
}
