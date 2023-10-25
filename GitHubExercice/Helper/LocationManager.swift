//
//  LocationManager.swift
//  GitHubExercice
//
//  Created by test on 24/10/2023.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject {
    //Instance de CLLocationManager
    //manager va nous permettre d'acceder à toutes les propriétés de CLLocationManager
    private let manager = CLLocationManager()
    
    //Va update notre vue(Map)
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    //En lien avec le info p.list
    //Sans ça on peut pas faire la demande à l'utilisateur
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
       
    }
}

//Ici je fais une extension pour gagner en lisibilité, j'aurais pu intégrer l'ensemble du block de code dans ma classe
//J'appelle le protocole CLLocationManagerDelegate -> les delegate permettent la coordination des changements pour l'utilisateur sur notre map

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("DEBUG: not determined")
        case .restricted:
            print("DEBUG: restricted")
        case .denied:
            print("DEBUG: denied")
        case .authorizedAlways:
            print("DEBUG: authorized always")
        case .authorizedWhenInUse:
            print("DEBUG: authorised when in use")
        case .authorized:
            print("DEBUG: authorized")
        @unknown default:
            fatalError()
        }
    }
    // cf: ici on update la localisation une fois que l'utilisateur nous a donné sa permission
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }
}
