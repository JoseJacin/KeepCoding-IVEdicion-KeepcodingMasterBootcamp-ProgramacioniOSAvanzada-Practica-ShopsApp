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
let urlFileJSON : String = "http://madrid-shops.com/json_new/getShops.php"
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
func downloadAndSaveJSONFile(success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {

    // Se comprueba si la aplicación se ha ejecutado anteriormente en algún momento mediante la carga del fichero desde NSUserDefaults
    guard let shopJSONData: Data = UserDefaults.standard.data(forKey: shopJSONDataKey) else {
        // No se ha podido obtener el fichero JSON, por lo que se procede a su descarga
        // Se recupera la URL del JSON
        guard let apiURL = URL(string: urlFileJSON) else {
            failure(ShopError.wrongURLFormatForJSONResource)
            return
        }
        
        URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    guard let jsonDownloadedData = data else {
                        throw ShopError.dataCollectionPointedByURLNotReachable
                    }
                    
                    // Se almacena el fichero JSON en NSUserDefaults
                    UserDefaults.standard.set(jsonDownloadedData, forKey: shopJSONDataKey)
                    
                    // Se retorna el fichero JSON
                    success(jsonDownloadedData)
                }catch let error as NSError{
                    print(error)
                }
            }
        }.resume()
        return
    }
    
    // Se ha podido obtener el fichero desde NSUserDefaults
    success(shopJSONData)
}

//MARK: - Loading JSON from local file (SandBox)
// Función que carga un fichero en local y retorna un array de JSON
func loadJSONFromSandBox(context: NSManagedObjectContext) throws -> [Shop] {
    
    var array2 : [Shop] = []
    //do {
        // Se carga el fichero desde NSUserDefauls
        //let jsonData = try downloadAndSaveJSONFile()

        
        // Se ejecuta la petición
        downloadAndSaveJSONFile(
                         // Se imprime el perfil en caso de que todo haya ido bien
            success: {
                // Se descarga la información del fichero JSON y se parsea a un array de JSON
                do {
                    guard let maybeArray = try? JSONSerialization.jsonObject(with: $0, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [[String: String]],
                        let array = maybeArray else {
                       throw ShopError.jsonParsingError
                    }

                
                    // Se ha descargado correctamente el fichero a local y se ha transformado el diccionario JSON a Shops
                    array2 = array.flatMap({ (dict: [String : String]) -> Shop? in
                        guard let id: String = dict["id"],
                            let name: String = dict["name"],
                            let address: String = dict["address"],
                            let telephone: String = dict["telephone"],
                            let email: String = dict["email"],
                            let gps_lat: String = dict["gps_lat"],
                            let gps_lon: String = dict["gps_lon"],
                            let img: String = dict["img"],
                            let logo_img: String = dict["logo_img"],
                            let description_es: String = dict["description_es"],
                            let description_en: String = dict["description_en"] else {
                                return nil
                        }
                    
                        // Se ha recuperado todo correctamente
                        let shop = Shop(id: id, name: name, address: address, telephone: telephone, email: email, gps_lat: gps_lat, gps_lon: gps_lon, img: img, logo_img: logo_img, description_es: description_es, description_en: description_en, context: context)
                    
                        return shop
                    })
                }catch let error as NSError{
                    print(error)
                }
                //return array2
        },
        // Se imprime el error en caso en que algo haya fallado
        failure: { print($0) })
    //} catch {
      //  throw ShopError.dataCollectionPointedByURLNotReachable
   // }
    return array2
}
