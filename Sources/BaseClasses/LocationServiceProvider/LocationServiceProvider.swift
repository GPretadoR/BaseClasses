//
//  LocationServiceProvider.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 6/3/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Combine
import CoreLocation

class LocationServiceProvider: NSObject, LocationServices {

    var currentLocation = CurrentValueSubject<CLLocation, Error>(CLLocation())
    var locationSubject = PassthroughSubject<CLLocation, Error>()
    var locationAuthorizationSubject = PassthroughSubject<CLAuthorizationStatus, Error>()

    var pausesLocationUpdatesAutomatically: Bool {
        get { return locationManager.pausesLocationUpdatesAutomatically }
        set { locationManager.pausesLocationUpdatesAutomatically = newValue }
    }

    var allowsBackgroundLocationUpdates: Bool {
        get { return locationManager.allowsBackgroundLocationUpdates }
        set { locationManager.allowsBackgroundLocationUpdates = newValue }
    }

    private let kLocationDistanceFilter: CLLocationDistance = 10

    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        configure()
    }

    // MARK: - Public functions
    func updateLocation() {
        locationManager.requestLocation()
    }

    func enableUpdateLocation() {
        locationManager.startUpdatingLocation()
    }

    func disableUpdateLocation() {
        locationManager.stopUpdatingLocation()
    }

    func mockCurrentLocation(location: [CLLocation]) { // Need this stupid thing for changing location from the app
        locationManager.delegate?.locationManager?(locationManager, didUpdateLocations: location)
    }

    func checkAuthorizationStatus() {
        requestAuthorizationForLocationService()
    }

    private func enableUpdateHeading() {
        locationManager.startUpdatingHeading()
    }

    private func disableUpdateHeading() {
        locationManager.stopUpdatingHeading()
    }

    // MARK: - Private functions

    private func configure() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.activityType = .fitness
//        locationManager.distanceFilter = kLocationDistanceFilter
        locationManager.delegate = self
        requestAuthorizationForLocationService()
    }

    private func requestAuthorizationForLocationService() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            disableUpdateLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            break
        @unknown default:
            fatalError()
        }
        locationAuthorizationSubject.send(CLLocationManager.authorizationStatus())
    }

}

extension LocationServiceProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location: CLLocation = locations.last {
            currentLocation.value = location
            locationSubject.send(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            disableUpdateLocation()
        case .notDetermined:
            requestAuthorizationForLocationService()
        case .authorizedAlways, .authorizedWhenInUse:
            enableUpdateLocation()
        default:
            break
        }
        locationAuthorizationSubject.send(status)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        disableUpdateLocation()
        locationSubject.send(completion: .failure(error))
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {}
}
