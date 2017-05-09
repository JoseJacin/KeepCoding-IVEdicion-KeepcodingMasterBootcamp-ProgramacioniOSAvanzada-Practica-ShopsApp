//
//  Constants.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 8/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation

struct Constants {
    //MARK: - Database
    static let dbName = "ShopsApp"
    static let entity = "Shop"
    
    //MARK: - Segues
    // Shop Detail Screen
    static let ShopDetailScreen = "ShopDetailScreen"
    
    //MARK: - Shop
    static let id = "id"
    static let name = "name"
    static let address = "address"
    static let telephone = "telephone"
    static let email = "email"
    static let gps_lat = "gps_lat"
    static let gps_lon = "gps_lon"
    static let img = "img"
    static let logo_img = "logo_img"
    static let description_es = "description_es"
    static let description_en = "description_en"
    
    // Shops Screen
    static let ShopCell = "ShopCell"
    
    // Cache
    static let CacheMaster = "Master"
    
    //Images
    static let ShopImageDefault = "Shop-Default"
    static let PngExtension = "png"
    
    //JSON
    static let urlFileJSON = "https://madrid-shops.com/json_new/getShops.php"
    static let shopJSONDataKey = "ShopJSONDataKey"
    static let result = "result"
}
