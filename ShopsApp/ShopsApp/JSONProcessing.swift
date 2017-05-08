//
//  JSONProcessing.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 8/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import Foundation
import CoreData

//MARK: - Constants
let urlFileJSON : String = "https://madrid-shops.com/json_new/getShops.php"
let shopJSONDataKey = "ShopJSONDataKey"

//MARK: - Aliases
// El protocolo AnyObject representa cualquier objeto que sea compatible con Objective C.
typealias JSONObject        = AnyObject;
typealias JSONDictionary    = [String: JSONObject]
typealias JSONArray         = [JSONDictionary]

// Función que decodifica un diccionario opcional JSON en un objeto del tipo Shop
func decode(shop json: JSONDictionary?) throws -> Shop {
    // Se valida que
    guard let json = json else {
        throw ShopError.nilJSONObject
    }
    return try decode(shop: json)
}

//MARK: - FileManager
// Función que retorna la URL del path Documents
func getMyDocumentsURL() -> URL {
    let sourcePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return sourcePath[0]
}

//MARK: - Download JSON
// Función que descarga el fichero JSON (si aplica) y lo guarda en Local en el path de Documents
func downloadAndSaveJSONFile() throws -> Data {

    // Se comprueba si la aplicación se ha ejecutado anteriormente en algún momento mediante la carga del fichero desde NSUserDefaults
    guard let shopJSONData: Data = UserDefaults.standard.data(forKey: shopJSONDataKey) else {
        // No se ha podido obtener el fichero JSON, por lo que se procede a su descarga
        // Se recupera la URL del JSON
        guard let jsonUrl = URL(string: urlFileJSON) else {
            throw ShopError.wrongURLFormatForJSONResource
        }
        
        // Se recupera el JSON referenciado por la URL
        guard let jsonDownloadedData = try? Data(contentsOf: jsonUrl) else {
            throw ShopError.dataCollectionPointedByURLNotReachable
        }
        
        // Se almacena el fichero JSON en NSUserDefaults
        UserDefaults.standard.set(jsonDownloadedData, forKey: shopJSONDataKey)
        
        // Se retorna el fichero JSON
        return jsonDownloadedData
    }
    
    // Se ha podido obtener el fichero desde NSUserDefaults
    return shopJSONData
}

//MARK: - Loading JSON from local file (SandBox)
// Función que carga un fichero en local y retorna un array de JSON
func loadJSONFromSandBox(context: NSManagedObjectContext) -> Bool {
        // Se carga el fichero desde NSUserDefauls
        guard let jsonData = try? downloadAndSaveJSONFile() else {
            fatalError("Unable to download or parse a JSON file")
        }

        // Se descarga la información del fichero JSON y se parsea a un array de JSON
    guard let root = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                fatalError(ShopError.wrongJSONFormat.localizedDescription)
        }

    guard let dictionary = root as? JSONDictionary else {
        fatalError(ShopError.wrongJSONFormat.localizedDescription)

    }
    
    guard let maybeArray = dictionary["result"] as? JSONArray else {
        fatalError(ShopError.wrongJSONFormat.localizedDescription)

    }
    
        guard let _ = try? decodes(shops: maybeArray, context: context) else {
            fatalError("Unable to decode a JSON")
        }
        return true
}


//MARK: - Decodification
func decode(shop dict: JSONDictionary, context: NSManagedObjectContext) throws {
    
    // validate first
    //try validate(dictionary: dict)
    
    let _ = Shop(json: dict, context: context)
}

func decode(shop dict: JSONDictionary?, context: NSManagedObjectContext) throws {
    
    guard let d = dict else {
        throw JSONErrors.emptyJSONObject
    }
    let _ = try decode(shop: d, context: context)
}

func decodes(shops dicts: JSONArray, context: NSManagedObjectContext) throws {
    
    let _ = try dicts.flatMap{
        try decode(shop: $0, context: context)
    }
}

func decodes(shops dicts: JSONArray?, context: NSManagedObjectContext) throws {
    guard let ds = dicts else {
        throw JSONErrors.emptyJSONArray
    }
    let _ = try decodes(shops: ds, context: context)
}

//MARK: - Validation
// Validation should be kept waya from processing to
// insure the single responsability principle
// https://medium.com/swift-programming/why-swift-guard-should-be-avoided-484cfc2603c5#.bd8d7ad91
private
func validate(dictionary dict: JSONDictionary) throws{
    
    func isMissing() throws{
        for key in dict.keys{
            guard let _ = dict[key] else{
                throw JSONErrors.missingField(name: key)
            }
        }
    }
    
    try isMissing()
}


//MARK: - Parsing
//At the moment it is not needed, but it is left by itself in the future it is necessary l to include more fields of a shop
func parseCommaSeparated(string s: String)->[String]{
    return s.components(separatedBy: ",").map({ $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)}).filter({ $0.characters.count > 0})
}

