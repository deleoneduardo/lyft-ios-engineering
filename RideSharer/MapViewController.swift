//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupMapView()
        }

        func setupMapView() {
            mapView.showsUserLocation = true
            mapView.delegate = self
            checkLocationAuthorization()
        }

        func checkLocationAuthorization() {
            let status = CLLocationManager.authorizationStatus()

            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                break
            case .denied:
                showLocationPermissionAlert()
            case .notDetermined:
                requestLocationPermission()
            case .restricted:
                break
            @unknown default:
                break
            }
        }

        func requestLocationPermission() {
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }

        func showLocationPermissionAlert() {
            let alert = UIAlertController(
                title: "Location Access Denied",
                message: "Please enable location access in Settings to use this feature.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            present(alert, animated: true, completion: nil)
        }
    }

    extension MapViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
    }
