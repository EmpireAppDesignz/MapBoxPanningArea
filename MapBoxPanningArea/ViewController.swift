//
//  ViewController.swift
//  MapBoxPanningArea
//
//  Created by Eric Rosas on 8/29/19.
//  Copyright © 2019 Eric Rosas. All rights reserved.
//

import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
    private var university: MGLCoordinateBounds!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self

        // University
        let center = CLLocationCoordinate2D(latitude: 24.72712, longitude: 46.63535)
        
        // Starting point
        mapView.setCenter(center, zoomLevel: 15, direction: 0, animated: false)
        
        //MAKE SURE YOU ADD YOUR API KEY INFO.PLIST
        // This area creates the boundry for the user to move around in and zoom in and out
        // boundaries to restrict the camera movement.
        let northeast = CLLocationCoordinate2D(latitude: 24.748169, longitude: 46.653019)
        let southwest = CLLocationCoordinate2D(latitude: 24.718878, longitude: 46.627661)
        university = MGLCoordinateBounds(sw: southwest, ne: northeast)
        
        view.addSubview(mapView)
    }
    
    func mapView(_ mapView: MGLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera) -> Bool {
        
        // Get the current camera to restore it after.
        let currentCamera = mapView.camera
        
        // From the new camera obtain the center to test if it’s inside the boundaries.
        let newCameraCenter = newCamera.centerCoordinate
        
        // Set the map’s visible bounds to newCamera.
        mapView.camera = newCamera
        let newVisibleCoordinates = mapView.visibleCoordinateBounds
        
        // Revert the camera.
        mapView.camera = currentCamera
        
        // Test if the newCameraCenter and newVisibleCoordinates are inside self.colorado.
        let inside = MGLCoordinateInCoordinateBounds(newCameraCenter, self.university)
        let intersects = MGLCoordinateInCoordinateBounds(newVisibleCoordinates.ne, self.university) && MGLCoordinateInCoordinateBounds(newVisibleCoordinates.sw, self.university)
        
        return inside && intersects
    }
}
