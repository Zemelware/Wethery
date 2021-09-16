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
        let feelsLike: Double
        struct Weather: Codable {
            let description: String
            let icon: String
            var weatherIconURL: URL? {
                let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                return URL(string: urlString)
            }
        }
        let weather: [Weather]
    }
    let current: Current
    
    struct Hourly: Codable {
        let dt: Date
        let temp: Double
        let feelsLike: Double
        struct Weather: Codable {
            let description: String
            let icon: String
            var weatherIconURL: URL? {
                let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                return URL(string: urlString)
            }
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
        struct Weather: Codable {
            let description: String
            let icon: String
            var weatherIconURL: URL? {
                let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                return URL(string: urlString)
            }
        }
        let weather: [Weather]
    }
    let daily: [Daily]
}
