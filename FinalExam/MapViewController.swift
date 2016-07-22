//
//  MapViewController.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var longtitude: String?
    var latitude: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude!)!, longitude: Double(longtitude!)!)
        self.mapView.addAnnotation(annotation)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "SpotPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        return annotationView
    }


}
