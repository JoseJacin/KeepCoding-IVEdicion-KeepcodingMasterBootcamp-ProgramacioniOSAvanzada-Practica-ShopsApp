//
//  ShopsViewController.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 8/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import MapKit

class ShopsViewController: UIViewController {
    //MARK: - CoreData
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Shop>? = nil
    
    //MARK: - Outlets
    @IBOutlet weak var mapShopsView: MKMapView!
    @IBOutlet weak var tableShopsView: UITableView!
    
    //MARK: - Location
    var locationManager : CLLocationManager?
    var location: MapPin?
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let _ = context else { return }
        
        tableShopsView.delegate = self
        tableShopsView.dataSource = self
        fetchedResultsController.delegate = self
        
        addLocationsInMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier
            {
            case Constants.ShopDetailScreen:
                let selectedIndex = tableShopsView.indexPathForSelectedRow
                let shop = fetchedResultsController.object(at: selectedIndex!)
                let vc = segue.destination as! ShopDetailViewController
                vc.shop = shop
            default:
                break
            }
        }
    }
    
}


