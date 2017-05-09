//
//  ShopsViewController+ShopsMapView.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 9/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation
import MapKit

extension ShopsViewController: CLLocationManagerDelegate {
    //Load all annotations with location to the map
    func addLocationsInMap(){
        // Se eliminan las anotaciones que ya existen en el mapa
        self.mapShopsView.removeAnnotations(self.mapShopsView.annotations)
        // Se recorren todos los elementos
        if let objects = fetchedResultsController.fetchedObjects{
            
            for each in objects {
                let shop : Shop = each as Shop
                
                if let lng: CLLocationDegrees = Double(shop.gps_lat!),
                    let lat: CLLocationDegrees = Double(shop.gps_lat!){
                    let coordinate = CLLocationCoordinate2DMake(lat, lng)
                    self.mapShopsView.addAnnotation(coordinate as! MKAnnotation)
                }
            }
        }
        
        let madridLocation = CLLocation(latitude: 40.4045, longitude: -3.7359)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.2, 0.2))
        
        mapShopsView.setRegion(region, animated: true)
    }
}
