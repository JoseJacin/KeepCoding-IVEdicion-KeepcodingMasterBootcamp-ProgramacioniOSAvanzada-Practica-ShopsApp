//
//  ShopsViewController.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 9/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

//NOTE: 
import Foundation
import CoreData

//NOTE: Implemented in Everpobre Practice
extension ShopsViewController: NSFetchedResultsControllerDelegate {
    // Función que se ejecuta cuando se crea/elimina una sección (groupBy) en el fetchedresultsController
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        // Se actualiza la tableView
        switch type {
        //case .insert:
            //self.collectionView.insertSections(IndexSet(integer: sectionIndex))
        //case .delete:
            //self.collectionView.deleteSections(IndexSet(integer: sectionIndex))
        default:
            return
        }
    }
    
    // Función que se ejecuta cuando una sección se ha modificado (insert/delete/update/move) un registro en el contexto
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
       // case .insert:
            //collectionView.insertItems(at: [newIndexPath!])
       // case .delete:
            //collectionView.deleteItems(at: [indexPath!])
        default:
            break
            //self.configureCell(collectionView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
        }
    }
}
