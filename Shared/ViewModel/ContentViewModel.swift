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
    
    func getWeather(for location: String) {
        
        getCoordinateFrom(address: location) { coordinate, error in
            guard let coordinate = coordinate, error == nil else {
                print("Invalid Location")
                return
            }
            
            self.getCityFrom(coordinate: coordinate) { city, error in
                guard let city = city, error == nil else {
                    print("Invalid Coordinates")
                    return
                }
                self.cityName = city
                
                DispatchQueue.main.async {
                    NetworkManager.shared.getWeather(from: coordinate) { result in
                        switch result {
                        case .success(let forecast):
                            self.forecast = forecast
                            
                            self.dateFormatter.dateFormat = "EEEE" // Display the date of the week
                            
                        case .failure(let error):
                            switch error {
                            case .invalidData:
                                self.alertItem = AlertContext.invalidData
                            case .invalidURL:
                                self.alertItem = AlertContext.invalidURL
                            case .unableToComplete:
                                self.alertItem = AlertContext.unableToComplete
                            }
                        }
                    }
                }
            }
        
        }
    }
    
    /// Change any location (City, Country, Address, Postal Code, etc.) into coordinates.
    private func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    /// Change any coordinate to a city.
    private func getCityFrom(coordinate: CLLocationCoordinate2D, completion: @escaping(_ cityName: String?, _ error: Error?) -> () ) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { completion($0?.first?.locality, $1) }
    }
    
}
