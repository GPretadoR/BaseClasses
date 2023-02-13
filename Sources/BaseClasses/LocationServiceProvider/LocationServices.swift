//
//  LocationServices.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 6/3/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Combine
import CoreLocation

protocol LocationServices {
    var currentLocation: CurrentValueSubject<CLLocation, Error> { get set }
}
