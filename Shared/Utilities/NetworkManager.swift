//
//  NetworkManager.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-09.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func weather(from coordinate: CLLocationCoordinate2D, unit: String = "metric") async throws -> Forecast {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?appid=\(APIKey)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=\(unit)&exclude=minutely"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // When it decodes a JSON object into a date it will use this method so the date shows up correctly
        decoder.keyDecodingStrategy = .convertFromSnakeCase // Convert snake to camel case
        
        guard let decodedData = try? decoder.decode(Forecast.self, from: data) else { throw NetworkError.invalidData }
        return decodedData
    }
}
