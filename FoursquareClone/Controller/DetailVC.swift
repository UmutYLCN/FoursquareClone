//
//  DetailVC.swift
//  FoursquareClone
//
//  Created by umut yalçın on 6.10.2023.
//

import UIKit
import MapKit
import ParseSwift

class DetailVC: UIViewController, MKMapViewDelegate{

    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailAtmosphereLbl: UILabel!
    
    
    @IBOutlet weak var detailNameLbl: UILabel!
    
    
    @IBOutlet weak var detailTypeLbl: UILabel!
    
    
    var choosenPlaceId = ""
    var choosenLatitude = Double()
    var choosenLongtitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
       
    }
    override func viewDidAppear(_ animated: Bool) {
        getDataFromParse()
    }
    
    
    private func getDataFromParse(){
        
        let constraint: QueryConstraint = "objectId" == choosenPlaceId
        let query = Place.query(constraint)
        
        query.find { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let item):
                    
                    
                    if let placeName = item[0].name as? String {
                        detailNameLbl.text = placeName
                    }
                    
                    if let placeType = item[0].type as? String {
                        detailTypeLbl.text = placeType
                    }
                    
                    if let placeAtmospehere = item[0].atmosphere as? String {
                        detailAtmosphereLbl.text = placeAtmospehere
                    }
                    
                    if let placeLatitude = item[0].latitude as? String {
                        if let placeLatitudeDouble = Double(placeLatitude) {
                            choosenLatitude = placeLatitudeDouble
                        }
                    }
                    
                    if let placeLongtitude = item[0].longitude as? String {
                        if let placeLongtitudeDouble = Double(placeLongtitude) {
                            choosenLongtitude = placeLongtitudeDouble
                        }
                    }
            
                    
                    
                    if let imageData = item[0].image as? ParseFile {
                        detailImageView.loadUrl(url: imageData.url!)
                    }
                    
                    
                    let location = CLLocationCoordinate2D(latitude: choosenLatitude, longitude: choosenLongtitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    mapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = detailNameLbl.text!
                    annotation.subtitle = detailTypeLbl.text!
                    self.mapView.addAnnotation(annotation)
                    
                    
                    
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alert(message: "\(error.message)")
                    }
                }
        }
    
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           if annotation is MKUserLocation {
               return nil
           }
           
           let reuseId = "pin"
           
           var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
           
           if pinView == nil {
               pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
               pinView?.canShowCallout = true
               let button = UIButton(type: .detailDisclosure)
               pinView?.rightCalloutAccessoryView = button
           } else {
               pinView?.annotation = annotation
           }
           
           return pinView
           
       }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if self.choosenLongtitude != 0.0 && self.choosenLatitude != 0.0 {
                let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongtitude)
                
                CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                    if let placemark = placemarks {
                        
                        if placemark.count > 0 {
                            
                            let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                            let mapItem = MKMapItem(placemark: mkPlaceMark)
                            mapItem.name = self.detailNameLbl.text
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                            mapItem.openInMaps(launchOptions: launchOptions)
                        }
                        
                    }
                }
                
            }
        }



}
