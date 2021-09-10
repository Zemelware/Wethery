//
//  AddressToCoordinate.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-09.
//

import CoreLocation

func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
    CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
}

//let address = "Vaughan"
//
//getCoordinateFrom(address: address) { coordinate, error in
//    guard let coordinate = coordinate, error == nil else { return }
//    DispatchQueue.main.async {
//        print("\(coordinate.latitude), \(coordinate.longitude)")
//    }
//}
