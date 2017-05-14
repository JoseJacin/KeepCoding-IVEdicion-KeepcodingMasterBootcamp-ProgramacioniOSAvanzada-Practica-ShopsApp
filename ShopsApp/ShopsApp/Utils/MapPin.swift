//
//  MapPin.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 9/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation
import MapKit

//NOTE: Implemented in Map Hello World
// Clase que pone un pin (anotación del mapa) sobre el mapa
class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    // El modelo se le pasa a la clase y después se inicializa en el init
    //let myModelObject: Notebook
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
