//
//  StateMapViewController.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/13/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit
import MapKit

class StateMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    var state: Statewise!{
        didSet{
            showLocation(locationName: state?.state)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showLocation(locationName: String?){
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationName
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start{ (response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let latitude = response!.boundingRegion.center.latitude
            let longitude = response!.boundingRegion.center.longitude
            
            let annotation = MKPointAnnotation()
            annotation.title = locationName
            annotation.subtitle = "Total Deaths:\(self.state?.confirmed ?? 0)"
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            self.mapView.addAnnotation(annotation)
            
            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
            
            self.callAlert(confirmed: "\(self.state.confirmed!)", active: "\(self.state.active!)", deaths: "\(self.state.deaths!)", recovered: "\(self.state.recovered!)")
        }
    }
    
    func callAlert(confirmed: String, active: String, deaths: String, recovered: String){
        
        let alert = UIAlertController(title: "\(state.state ?? "")", message: "Total: \(confirmed) \n Active: \(active) \n Recovered: \(recovered) \n Deaths: \(deaths)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
