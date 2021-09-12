//
//  ContentViewModel.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-10.
//

import Foundation
import CoreLocation


final class ContentViewModel: ObservableObject {
    @Published var forecast: Forecast?
    
    let dateFormatter = DateFormatter()
    
    func getWeather(for location: String) {
        
        getCoordinateFrom(address: location) { coordinate, error in
            guard let coordinate = coordinate, error == nil else {
                print("Invalid Location")
                return
            }
            
            DispatchQueue.main.async {
                NetworkManager.shared.getWeather(from: coordinate) { result in
                    switch result {
                    case .success(let forecast):
                        self.forecast = forecast
                        
                        self.dateFormatter.dateFormat = "EEEE" // Display the date of the week
//                        for day in forecast.daily {
//                            print("\(self.dateFormatter.string(from: day.dt)) | \(day.temp.min) - \(day.temp.max)")
//                        }
                        
                    case .failure(let error):
                        switch error {
                        case .invalidData:
                            print("Invalid data")
                        case .invalidURL:
                            print("Invalid URL")
                        case .unableToComplete:
                            print("Unable to complete")
                        }
                    }
                }
            }
        }
    }
    
    private func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
}