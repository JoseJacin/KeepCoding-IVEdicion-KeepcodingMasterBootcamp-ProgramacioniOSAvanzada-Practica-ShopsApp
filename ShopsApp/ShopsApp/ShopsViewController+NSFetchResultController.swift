//
//  ShopsViewController+NSFetchResultController.swift
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
    // MARK: - Fetched results controller
    var fetchedResultsController: NSFetchedResultsController<Shop> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: Shop.fetchRequestOrderedByName(), managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: Constants.CacheMaster)
        _fetchedResultsController?.delegate = self
        
        do {
            // Descarga el primer bloque de registros (20)
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    // Función que se ejecuta cuando se crea/elimina una sección (groupBy) en el fetchedresultsController
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        // Se actualiza la tableView
        switch type {
        case .insert:
            self.tableShopsView.insertSections(IndexSet(integer: sectionIndex), with: .top)
        case .delete:
            self.tableShopsView.deleteSections(IndexSet(integer: sectionIndex), with: .top)
        default:
            return
        }
    }
    
    // Función que se ejecuta cuando una sección se ha modificado (insert/delete/update/move) un registro en el contexto
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableShopsView.insertRows(at: [newIndexPath!], with: .top)
        case .delete:
            self.tableShopsView.deleteRows(at: [indexPath!], with: .top)
        default:
            break
        }
    }
}
