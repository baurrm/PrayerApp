//
//  ViewController.swift
//  Namaz
//
//  Created by Bauyrzhan Marat on 01.08.2022.
//
import UIKit
import CoreLocation

class TimeViewController: UIViewController {
    
    var apiKey = "f0e348543cc1093c4f71f13fb295f392"
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var cityName = ""
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    
    
    //MARK: - Access users location
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    func fetchTime(cityName: String) {
        let urlString = "https://muslimsalat.com/\(cityName).json?key=\(apiKey)"
        print(urlString)
    }
    
}

extension TimeViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
                if error == nil {
                    if let firstLocation = placemarks?[0],
                        let cityName = firstLocation.locality {
                        self?.cityLabel.text = String(cityName)
                        self?.fetchTime(cityName: cityName)
                        self?.locationManager.stopUpdatingLocation()
                    }
                }
            }
        }
    }
    
    
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    
}





