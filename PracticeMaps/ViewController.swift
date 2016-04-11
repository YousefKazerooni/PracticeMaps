//
//  ViewController.swift
//  PracticeMaps
//
//  Created by Yousef Kazerooni on 4/5/16.
//  Copyright © 2016 YousefKazerooni. All rights reserved.
//

//"galleryLongitude": -122.3915697,
//"galleryLattitude": 37.754252,


import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var lastLocation : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        
        mapView.delegate = self
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1)), animated: false)
        addPin()
        //mapView(MKMapView, didSelectAnnotationView: MKAnnotationView)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addPin() {
        let annotation = MKPointAnnotation()
        var locationCoordinate = CLLocationCoordinate2DMake(37.754252, -122.3915697)
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)
    }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        var annotations = [mapView.userLocation]
        mapView.showAnnotations(annotations, animated: true)
    }
    
    
    //address
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        var appleMapsURL = "http://maps.apple.com/?q=\(view.annotation!.coordinate.latitude),\(view.annotation!.coordinate.longitude)"
        UIApplication.sharedApplication().openURL(NSURL(string: appleMapsURL)!)
        
        var annotations: [MKAnnotation] = [mapView.userLocation, view.annotation!]
        mapView.showAnnotations(annotations, animated: true)
        
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
            var location: CLLocation = locations.first!
            lastLocation = location.coordinate
        
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            let span = MKCoordinateSpanMake(0.1, 0.1)
//            let region = MKCoordinateRegionMake(location.coordinate, span)
//            mapView.setRegion(region, animated: false)
//        }
//    }
    
    
    
    
    //add image
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        let reuseID = "myAnnotationView"
//        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView //the type added from mapt
//        if (annotationView == nil) {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
//        } else {
//    annotationView!.annotation = annotation   // the else is from the map tutorial
//    }
    
//        annotationView!.pinTintColor = UIColor.greenColor()  //added from map t
//        annotationView!.image = UIImage(named: "pinImage")
//        return annotationView
//    }
    
 

    


}

