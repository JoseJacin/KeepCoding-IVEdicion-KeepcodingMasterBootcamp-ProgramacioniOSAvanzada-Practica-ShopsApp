//
//  ShopDetailViewController.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 9/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class ShopDetailViewController: UIViewController {
    //MARK: - Properties
    var shop: Shop? = nil
    
    //MARK: - Outlets
    @IBOutlet weak var descShop: UITextView!
    @IBOutlet weak var imageShop: UIImageView!
    @IBOutlet weak var addressShop: UILabel!
    @IBOutlet weak var mapImageShops: UIImageView!
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = shop?.name
        if (Locale.current.languageCode! == Constants.defaultLanguage) {
            descShop.text = shop?.description_es
        } else if (Locale.current.languageCode! == Constants.secondLanguage) {
            descShop.text = shop?.description_en
        }
        
        addressShop.text = shop?.address
        
        
        let defaultImageAsData = try! Data(contentsOf: Bundle.main.url(forResource: Constants.ShopImageDefault, withExtension: Constants.PngExtension)!)
        
        let asyncData = AsyncData(url: URL(string: (shop?.img)!)!, defaultData: defaultImageAsData)
        
        asyncData.delegate = self
        imageShop.image = UIImage(data: asyncData.data) // muestra la de ir tirando y empieza a descargar la buena
        
        
        let googleMapsImgAPI = URL(string: "\(Constants.googleMapsImageAPI1)\((shop?.gps_lat)!)\(Constants.googleMapsImageAPI2)\((shop?.gps_lon)!)\(Constants.googleMapsImageAPI3)\((shop?.gps_lat)!)\(Constants.googleMapsImageAPI4)\((shop?.gps_lon)!)")
        
        let googleMapsImgAPIData = try! Data(contentsOf: googleMapsImgAPI!)

        mapImageShops.image = UIImage(data: googleMapsImgAPIData) // muestra la de ir tirando y empieza a descargar la buena

       /* let asyncDataImgMap = AsyncData(url: URL(string: googleMapsImgAPI)!, defaultData: defaultImageAsData)
        asyncDataImgMap.delegate = self
        mapImageShops.image = UIImage(data: asyncDataImgMap.data) // muestra la de ir tirando y empieza a descargar la buena
 */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ShopDetailViewController: AsyncDataDelegate{
    
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
            UIView.transition(with: self.imageShop,
                              duration: 0.7,
                              options: [.transitionCrossDissolve],
                              animations: {
                                self.imageShop.image = UIImage(data: sender.data)
            }, completion: nil)
        }
    }
}
