//
//  LocationService.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 6/3/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Combine
import CoreLocation

class LocationService {

    private let serviceProvider: LocationServiceProvider

    var currentLocation: CurrentValueSubject<CLLocation, Error> {
        serviceProvider.currentLocation
    }

    var locationSubject: PassthroughSubject<CLLocation, Error> {
        serviceProvider.locationSubject
    }

    var locationAuthorizationSubject: PassthroughSubject<CLAuthorizationStatus, Error> {
        serviceProvider.locationAuthorizationSubject
    }

    init(serviceProvider: LocationServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    func checkAuthorizationStatus() {
        serviceProvider.checkAuthorizationStatus()
    }

    func getCountryOfLocation(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            guard let currentLocPlacemark = placemarks?.first,
                let isoCountryCode = currentLocPlacemark.isoCountryCode,
                let country = currentLocPlacemark.country
                else { return }

        }
    }
}
