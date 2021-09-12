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
        
    func getWeather(from coordinate: CLLocationCoordinate2D, in unit: String = "metric", completed: @escaping (Result<Forecast,APIError>) -> ()) {
        let forecastURL = "https://api.openweathermap.org/data/2.5/onecall?appid=\(APIKey)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=\(unit)&exclude=minutely"
        
        guard let url = URL(string: forecastURL) else { completed(.failure(.invalidURL)); return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { completed(.failure(.unableToComplete)); return }
            guard let data = data else { completed(.failure(.invalidData)); return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970 // When it decodes a JSON object into a date it will use this method so the date shows up correctly
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Convert snake to camel case
                let decodedData = try decoder.decode(Forecast.self, from: data)
                
                DispatchQueue.main.async {
                    completed(.success(decodedData))
                }
            } catch { completed(.failure(.invalidData)) }
        }.resume()
    }
}
