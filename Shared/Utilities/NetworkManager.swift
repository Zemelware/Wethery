//
//  NetworkManager.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-09.
//

import SwiftUI

class API {
    func getWeather(completion: @escaping (Forecast) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=43.8308&lon=79.4570&exclude=minutely&units=metric&appid=\(APIKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { print("Data was nil"); return }
            guard error == nil else { print(error!); return }
            
            do {
                let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
                
                DispatchQueue.main.async {
                    completion(forecastData)
                }
            } catch { print(error) }
        }.resume()
    }
}
