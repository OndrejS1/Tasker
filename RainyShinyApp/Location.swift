//
//  Location.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 23.02.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    public init() { }
    
    var latitude: Double!
    var longitude: Double!
    

}
