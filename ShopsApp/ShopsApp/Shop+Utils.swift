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
    convenience init (json: JSONDictionary, context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: Shop.entity().name!, in: context)!
        
        self.init(entity: entity, insertInto: context)
        self.id = json[Constants.id] as? String ?? "0"
        self.name = json[Constants.name] as? String ?? ""
        self.address = json[Constants.address] as? String ?? ""
        self.telephone = json[Constants.telephone] as? String ?? ""
        self.email = json[Constants.email] as? String ?? ""
        self.gps_lat = json[Constants.gps_lat] as? String ?? ""
        self.gps_lon = json[Constants.gps_lon] as? String ?? ""
        self.img = json[Constants.img] as? String ?? ""
        self.logo_img = json[Constants.logo_img] as? String ?? ""
        self.description_es = json[Constants.description_es] as? String ?? ""
        self.description_en = json[Constants.description_en] as? String ?? ""
        
        self.gps_lat = self.gps_lat?.trimmingCharacters(in: .whitespaces)
        self.gps_lon = self.gps_lon?.trimmingCharacters(in: .whitespaces)

        saveContext(context: context)
    }
    
    // Función que recupera los primeros 20 registros y los ordena por Nombre (name)
    //NOTE: Implemented in Everpobre Practice
    class func fetchRequestOrderedByName() -> NSFetchRequest<Shop> {
        let fetchRequest: NSFetchRequest<Shop> = Shop.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: Constants.name, ascending: true)
        
        // Se establece el orden de los resultados
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
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
