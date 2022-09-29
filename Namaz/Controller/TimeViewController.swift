//
//  ViewController.swift
//  Namaz
//
//  Created by Bauyrzhan Marat on 01.08.2022.
//
import UIKit
import CoreLocation

class TimeViewController: UIViewController {
    
    private var apiKey = "f0e348543cc1093c4f71f13fb295f392"
    private var cityName = ""
    private var locationManager = CLLocationManager()
    private var QiblaVC = QiblaViewController()
    private var labelText: String? = ""
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var fajrLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var dhuhrLabel: UILabel!
    @IBOutlet weak var asrLabel: UILabel!
    @IBOutlet weak var maghribLabel: UILabel!
    @IBOutlet weak var ishaLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    //Update User Interface
    func updateUI(decodedData: TimeData) {
        DispatchQueue.main.async {
            self.fajrLabel.text = decodedData.items[0].fajr
            self.sunriseLabel.text = decodedData.items[0].shurooq
            self.dhuhrLabel.text = decodedData.items[0].dhuhr
            self.asrLabel.text = decodedData.items[0].asr
            self.maghribLabel.text = decodedData.items[0].maghrib
            self.ishaLabel.text = decodedData.items[0].isha
            self.labelText = decodedData.qibla_direction
        }
    }
    
    //Request Location button pressed.
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    //Navigate to QiblaViewController.
    @IBAction func compassButton(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "goToQiblaViewContoller") as! QiblaViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
        nextViewController.qiblaDirectionLabel.text = labelText

    }
    
    //MARK: - Fetch the data from API
    func requestData(cityName: String) {
        let url = URL(string: "https://muslimsalat.com/\(cityName).json?key=\(apiKey)")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            
            if error != nil {
                print("An error has been occured while fetching the data from API.")
            }
            
            if let safeData = data {
                
                do {
                    let decodedData = try JSONDecoder().decode(TimeData.self, from: safeData)
                    updateUI(decodedData: decodedData)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}

//MARK: - User access to location
extension TimeViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
                if error == nil {
                    if let firstLocation = placemarks?[0],
                       let cityName = firstLocation.locality {
                        self?.cityLabel.text = String(cityName)
                        self?.requestData(cityName: cityName)
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





