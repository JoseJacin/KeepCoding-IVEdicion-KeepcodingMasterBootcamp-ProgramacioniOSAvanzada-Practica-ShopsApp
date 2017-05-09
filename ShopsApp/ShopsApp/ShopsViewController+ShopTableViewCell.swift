//
//  ShopsViewController+ShopTableViewCell.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 9/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ShopTableViewCell: UITableViewCell {
    //MARK: - CoreData
    var context: NSManagedObjectContext? = nil
    
    //MARK: - Outlets
    @IBOutlet weak var logoShopView: UIImageView!
    @IBOutlet weak var nameShopView: UILabel!
    
    //MARK: - Functions
    var _shop: Shop? = nil
    var shop: Shop{
        get{
            return _shop!
        }
        set{
            _shop = newValue
            
            nameShopView.text = newValue.name?.uppercased()
            
            let defaultImageAsData = try! Data(contentsOf: Bundle.main.url(forResource: Constants.ShopImageDefault, withExtension: Constants.PngExtension)!)
            
            let asyncData = AsyncData(url: URL(string: newValue.logo_img!)!, defaultData: defaultImageAsData)
            
            asyncData.delegate = self
            logoShopView.image = UIImage(data: asyncData.data) // muestra la de ir tirando y empieza a descargar la buena
        }
    }
    
}

extension ShopTableViewCell: AsyncDataDelegate{
    
    func asyncData(_ sender: AsyncData, shouldStartLoadingFrom url: URL) -> Bool {
        // Solicita permiso para realizar la descarga
        return true
    }
    
    func asyncData(_ sender: AsyncData, willStartLoadingFrom url: URL) {
        // Nos avisa que va a empezar
    }
    
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        // Avisa de que finalizó la descarga
        
        // Se actualiza la imagen
        DispatchQueue.main.async {
            // Update UI
            UIView.transition(with: self.logoShopView,
                              duration: 0.7,
                              options: [.transitionCrossDissolve],
                              animations: {
                                self.logoShopView.image = UIImage(data: sender.data)
            }, completion: nil)
        }
    }
}
