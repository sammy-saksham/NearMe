//
//  LandmarkAnnotation.swift
//  Near Me
//
//  Created by Saksham Jain on 26/01/21.
//

import Foundation
import MapKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
    
}
