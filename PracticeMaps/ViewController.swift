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
    let locationManager = CLLocationManager()
    
//    var locationManager: CLLocationManager!
//    var lastLocation : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //locationManager.distanceFilter = 200
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        mapView.delegate = self
//        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.2, 0.2)), animated: false)
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

    
//    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
//        var annotations = [mapView.userLocation]
//        mapView.showAnnotations(annotations, animated: true)
//    }
    
    
    //address
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        var appleMapsURL = "http://maps.apple.com/?q=\(view.annotation!.coordinate.latitude),\(view.annotation!.coordinate.longitude)"
        UIApplication.sharedApplication().openURL(NSURL(string: appleMapsURL)!)
        
        var annotations: [MKAnnotation] = [mapView.userLocation, view.annotation!]
        mapView.showAnnotations(annotations, animated: true)
        
    }
//
//    
//    
//    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
//            manager.startUpdatingLocation()
//        }
//    }
    
    //Should start showing where the user is!!!
    //used the tutorial from this website: https://www.youtube.com/watch?v=qrdIL44T6FQ
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D (latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion (center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
//        if let location = locations.first {
//            let span = MKCoordinateSpanMake(0.1, 0.1)
//            let region = MKCoordinateRegionMake(location.coordinate, span)
//            mapView.setRegion(region, animated: false)
//        }
//            var location: CLLocation = locations.first!
//            lastLocation = location.coordinate
        
    }
    
    //used this thread from stackover flow to resolve a bug: http://stackoverflow.com/questions/1409141/location-manager-error-kclerrordomain-error-0
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error \(error.localizedDescription)")
    }
    
    
    //Right clicking teje to go to details????
        func mapView(map: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if control == view.rightCalloutAccessoryView {
                performSegueWithIdentifier("toDetails", sender: view)
            }
        }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            let span = MKCoordinateSpanMake(0.1, 0.1)
//            let region = MKCoordinateRegionMake(location.coordinate, span)
//            mapView.setRegion(region, animated: false)
//        }
//    }
    
    
    
    
//    //add image
      //For some reason THIS PIECE OF CODE, turns the blue dot into a PIN!!!!
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        let reuseID = "myAnnotationView"
//        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView //the type added from mapt
//        if (annotationView == nil) {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
//        } else {
//    annotationView!.annotation = annotation   // the else is from the map tutorial
//    }
//    
//        //annotationView!.pinTintColor = UIColor.greenColor()  //added from map t
//        
//        //annotationView!.image = UIImage(named: "pinImage")
//        return annotationView
//    }
    
    //Prepare for segue way
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let annotation = (sender as! MKAnnotationView).annotation!;
            //let location = annotation as! Location;
            let detailVc = segue.destinationViewController as! DetailsViewController;
    }

    


}

