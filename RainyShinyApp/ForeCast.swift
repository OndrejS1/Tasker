//
//  ForeCast.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 23.02.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit
import Alamofire


class ForeCast {
    
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    
        
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
        
        
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
        
        
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
        
        
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                
            let kelvinToCelsius = min - 273.15
                
            self._lowTemp = kelvinToCelsius
            
                
            }
            if let max = temp["max"] as? Double {
                
                let kelvinToCelsius = max - 273.15
                
                self._highTemp = kelvinToCelsius
                
                
            }
    
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                
            }
            
            
        }
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date.init(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    
    }
    
}










