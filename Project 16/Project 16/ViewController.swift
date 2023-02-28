//
//  ViewController.swift
//  Project 16
//
//  Created by Евгения Зорич on 27.02.2023.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    let mapTypes = ["sattelite": MKMapType.satellite, "standart": MKMapType.standard, "hybrid": MKMapType.hybrid]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to 2012 Summer Olympics", url:  "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over f thousand years ago", url: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", url:  "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", url: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", url: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington)
        
        mapView.mapType = .standard

        let ac = UIAlertController(title: "Choose a style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "sattelite", style: .default, handler: setStyle))
        ac.addAction(UIAlertAction(title: "standart", style: .default, handler: setStyle))
        ac.addAction(UIAlertAction(title: "hybrid", style: .default, handler: setStyle))
        present(ac, animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(setMap))

    }
    
    func setStyle (action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let style = mapTypes[actionTitle] else { return }
        mapView.mapType = style
    }
    
    @objc func setMap() {
        let ac = UIAlertController(title: "Select map type", message: nil, preferredStyle: .actionSheet)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        for mapType in mapTypes.keys {
            ac.addAction(UIAlertAction(title: mapType, style: .default, handler: setStyle))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
               
               annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               annotationView?.canShowCallout = true
            annotationView?.markerTintColor = .magenta

               let btn = UIButton(type: .detailDisclosure)
               annotationView?.rightCalloutAccessoryView = btn
        } else {
            
            annotationView?.annotation = annotation
            annotationView?.markerTintColor = .magenta
        }

        return annotationView
       
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        let url = capital.url
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Wiki", style: .default, handler: { [weak self] _ in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Wiki") as? WikiViewController {
                vc.url = url
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }))
        present(ac, animated: true)
    }
}


