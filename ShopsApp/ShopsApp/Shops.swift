//
//  Shop.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 8/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import Foundation
import CoreData

extension Shop {
    //MARK: - Proxies
    // Proxy para igualdad
    func proxyForEquiality() -> String {
        return "\(name ?? "")\(address ?? "")\(telephone ?? "")\(email ?? "")\(gps_lat ?? "")\(gps_lon ?? "")\(img ?? "")\(logo_img ?? "")"
    }
    
    // Proxy para comparación
    func proxyForComparision() -> String {
        return proxyForEquiality()
    }
}
