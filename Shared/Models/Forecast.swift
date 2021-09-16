//
//  Weather.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-09.
//

import Foundation

struct Forecast: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Date
    let sunrise: Date
    let sunset: Date
    let temp: Double
    let feelsLike: Double
    let weather: [Weather]
}

struct Hourly: Codable {
    let dt: Date
    let temp: Double
    let feelsLike: Double
    let weather: [Weather]
}

struct Daily: Codable {
    let dt: Date
    let sunrise: Date
    let sunset: Date
    let temp: Temp
    let weather: [Weather]
}

struct Temp: Codable {
    let min: Double
    let max: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
    var weatherIconURL: URL? {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)
    }
}


struct MockData {
    static let forecast = Forecast(current: current, hourly: [], daily: [])
    static let current = Current(dt: Date(timeIntervalSince1970: 1631827700), sunrise: Date(timeIntervalSince1970: 1631838232), sunset: Date(timeIntervalSince1970: 1631883022), temp: 21.3, feelsLike: 23.1, weather: weather)
    static let weather = [Weather(description: "Broken Clouds", icon: "04n")]
}
