//
//  StateMapViewController.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/13/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel

class StateMapViewController: UIViewController, FloatingPanelControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var fpc: FloatingPanelController!
    var state: Statewise!{
        didSet{
            showLocation(locationName: state?.state)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        DispatchQueue.main.async{
            self.showFloatingScreen()
        }
        
        func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            fpc.removePanelFromParent(animated: true)
        }
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
            annotation.subtitle = "TOTAL CASES:\(self.state?.confirmed ?? 0)"
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            self.mapView.addAnnotation(annotation)
            
            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }

    func showFloatingScreen(){
        
        fpc = FloatingPanelController()
        fpc.delegate = self
        let graphVC = self.storyboard?.instantiateViewController(identifier: "GraphViewController") as! GraphViewController
        graphVC.state = self.state
        fpc.set(contentViewController: graphVC)
        fpc.addPanel(toParent: self)
    }
}
