//
//  Weather.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-09.
//

import Foundation

struct Forecast: Codable {
    struct Current: Codable {
        let dt: Date
        let sunrise: Date
        let sunset: Date
        let temp: Double
        let feels_like: Double
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        let weather: [Weather]
    }
    let current: Current
    struct Hourly: Codable {
        let dt: Date
        let temp: Double
        let feels_like: Double
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        let weather: [Weather]
    }
    let hourly: [Hourly]
    struct Daily: Codable {
        let dt: Date
        let sunrise: Date
        let sunset: Date
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
        let temp: Temp
    }
}
