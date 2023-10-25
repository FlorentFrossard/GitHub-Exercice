//
//  MapView.swift
//  GitHubExercice
//
//  Created by test on 24/10/2023.
//

import SwiftUI
import MapKit



//Toujours dans un soucis de lisibilité et de séparation de block de code j'utilise des extensions.

//Ici ma position perso
extension CLLocationCoordinate2D {
    static let userLocation = CLLocationCoordinate2D(
        latitude: 48.878367, longitude: 2.371827
    )
}
//Le niveau de zoom et le périmètre
extension MKCoordinateRegion {
    static let userRegion = MKCoordinateRegion(center: .userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
}
//Requête pour avoir les points d'interêts qu'on appelle de manière naturel (ex: resto, monuments)
extension MapView {
    func searchPlaces()  {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search //variable textfield
        request.resultTypes = .pointOfInterest
        request.region = .userRegion // La static var dans mon extension MKCoordinateRegion
       
        //Async
        Task {
            let result = try? await MKLocalSearch(request: request).start()
            self.result = result?.mapItems ?? []
        }
    }
}


struct MapView: View {
    //Instance de notre class
    @StateObject var locationManager = LocationManager()
    
    @State private var userLocation: MapCameraPosition = .region(.userRegion) //Permet d'afficher notre position
    @State private var search = ""
   
    @State private var result = [MKMapItem]() //tableau vide pour nos pts d'intérêts
    @State private var selection: MKMapItem? //Permet de notifier la selection d'un point d'intérêt
    
    
    var body: some View {
        
        Map(position: $userLocation, selection: $selection) {
            
            //Permet d'afficher le point bleu (notre position)
            UserAnnotation()
            
            //loop pour afficher les demandes de points d'intérêts specifiques (resto, monuments, etc...)
            ForEach(result, id:\.self) { item in
                let placemark = item.placemark
                Marker(placemark.name ?? "", coordinate: placemark.coordinate)
            }
         
        }
        .overlay(alignment: .bottom, content: {
            TextField("Recherche", text: $search)
                .padding(12)
                .background(.white)
                .padding()
        })
        .mapControls {
            MapPitchToggle() //Bouton 3D/2D
            MapUserLocationButton() //recentre sur notre localisation
        }
        //permet d'effectuer la demande de notre textfield une fois appuyer sur entrée
        .onSubmit(of: .text) {
            //Notre fonction de demande de points d'intérêts
            searchPlaces()
        }
        //Quand la vue apparait on est notifié de la permission
        .onAppear(perform: {
            locationManager.requestLocation()
        })
    }
}

#Preview {
    MapView()
}
