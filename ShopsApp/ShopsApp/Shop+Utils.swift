//
//  Shop+Utils.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 8/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation
import CoreData

extension Shop {
    //MARK: - Initialization
    convenience init (id: String = "",
                      name: String = "",
                      address: String = "",
                      telephone: String = "",
                      email: String = "",
                      gps_lat: String = "",
                      gps_lon: String = "",
                      img: String = "",
                      logo_img: String = "",
                      description_es: String = "",
                      description_en: String = "",
                      context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: Shop.entity().name!, in: context)!
        
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.address = address
        self.telephone = telephone
        self.email = email
        self.gps_lat = gps_lat
        self.gps_lon = gps_lon
        self.img = img
        self.logo_img = logo_img
        self.description_es = description_es
        self.description_en = description_en
        
        saveContext(context: context)
    }
    
    //MARK: - Proxies
    // Proxy para igualdad
    func proxyForEquiality() -> String {
        return "\(id ?? "")\(name ?? "")\(address ?? "")\(telephone ?? "")\(email ?? "")\(gps_lat ?? "")\(gps_lon ?? "")\(img ?? "")\(logo_img ?? "")"
    }
    
    // Proxy para comparación
    func proxyForComparision() -> String {
        return proxyForEquiality()
    }
}
