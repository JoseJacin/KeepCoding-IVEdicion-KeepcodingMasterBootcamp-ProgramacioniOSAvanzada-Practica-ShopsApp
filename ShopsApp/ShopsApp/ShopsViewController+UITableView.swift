//
//  ShopsViewController+UITableView.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 9/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation
import UIKit

//NOTE: Implemented in Everpobre Practice
extension ShopsViewController: UITableViewDelegate, UITableViewDataSource {
    // Función que establece el número de secciones del collectionView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Función que establece el número de items de cada sección del collectionView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    // Función que retorna el item sobre el que se está realizando una acción
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopTableViewCell
        cell.shop = self.fetchedResultsController.object(at: indexPath)
        //cell.context = self.context
        return cell
    }
}
