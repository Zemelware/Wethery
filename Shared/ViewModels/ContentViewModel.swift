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
    @Published var alertItem: AlertItem?
    @Published var cityName: String = ""
    
    let dateFormatter = DateFormatter()
    
    func getWeather(for location: String, completion: @escaping (Bool) -> ()) {
        
        getCoordinateFrom(address: location) { coordinate, error in
            guard let coordinate = coordinate, error == nil else {
                self.alertItem = AlertContext.invalidLocation
                completion(false) // Location is invalid
                return
            }
            completion(true) // Location is valid
            
            self.getCityFrom(coordinate: coordinate) { city, error in
                guard let city = city, error == nil else {
                    print("Invalid Coordinates")
                    return
                }
                self.cityName = city
                
                Task {
                    do {
                        self.forecast = try await NetworkManager.shared.weather(from: coordinate)
                        self.dateFormatter.dateFormat = "EEEE" // Display the date of the week
                    } catch NetworkError.invalidData {
                        self.alertItem = AlertContext.invalidData
                    } catch NetworkError.invalidURL {
                        self.alertItem = AlertContext.invalidURL
                    } catch NetworkError.invalidResponse {
                        self.alertItem = AlertContext.invalidResponse
                    } catch {
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        
        }
    }
    
    /// Change any location (City, Country, Address, Postal Code, etc.) into coordinates.
    private func getCoordinateFrom(address: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    /// Change any coordinate to a city.
    private func getCityFrom(coordinate: CLLocationCoordinate2D, completion: @escaping (_ cityName: String?, _ error: Error?) -> () ) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { completion($0?.first?.locality, $1) }
    }
    
}
