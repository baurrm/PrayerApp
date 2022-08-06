//
//  Time.swift
//  Namaz
//
//  Created by Bauyrzhan Marat on 03.08.2022.
//

struct TimeManager {
    
    let url = "https://muslimsalat.com/"
    let apiKey = "f0e348543cc1093c4f71f13fb295f392"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(url)\(cityName).json?key=\(apiKey)"
        print(urlString)
    }
    
    var fajr: String
    var sunrise: String
    var dhuhr: String
    var asr: String
    var magrib: String
    var isha: String
    
}


