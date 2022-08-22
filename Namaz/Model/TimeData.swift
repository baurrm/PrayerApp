//
//  Time.swift
//  Namaz
//
//  Created by Bauyrzhan Marat on 03.08.2022.
//
import Foundation

struct TimeData: Codable {
    let query: String
    let items: [Items]
}

struct Items: Codable {  
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let magrib: String
    let isha: String
}


