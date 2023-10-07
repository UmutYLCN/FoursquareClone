//
//  MapVC.swift
//  FoursquareClone
//
//  Created by umut yalçın on 6.10.2023.
//

import UIKit
import MapKit
import ParseSwift

class MapVC: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()

    var chosenLatitude = ""
    var chosenLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title : "Back", style: .done, target: self, action: #selector(handleBack))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        mapView.addGestureRecognizer(recognizer)
        
    }
    @objc
    func chooseLocation(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touches = gestureRecognizer.location(in: mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.shared.placeName
            annotation.subtitle = PlaceModel.shared.placeType

            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.shared.placeLatitude = String(coordinates.latitude)
            PlaceModel.shared.placeLongitude = String(coordinates.longitude)
            
            
        }
    }
    
    @objc
    func handleSave(){
        
        
        let placeModel = PlaceModel.shared
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5){
            let image = ParseFile(name: "image.jpg",data: imageData)
            
            DataPersintenceManager.shared.createPlaceObject(name: placeModel.placeName, type: placeModel.placeType, atmosphere: placeModel.placeAtmosphere, latitude: placeModel.placeLatitude, longitude: placeModel.placeLongitude,image: image)
        }
        
        performSegue(withIdentifier: "fromtoPlaceVC", sender: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
   
    
    @objc
    func handleBack(){
        self.dismiss(animated: true)
    }

}
