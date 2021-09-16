//
//  AlertItem.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-13.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {
    
    static let invalidURL = AlertItem(title: Text("Server Error"), message: Text("There is an error trying to reach the server."))
    static let unableToComplete = AlertItem(title: Text("Server Error"), message: Text("Unable to complete your request at this time. Please check your internet connection."))
    static let invalidData = AlertItem(title: Text("Server Error"), message: Text("The data received from the server was invalid. Please try again."))
    static let invalidLocation = AlertItem(title: Text("Invalid Location"), message: Text("The location inputted was invalid. Please enter a correct location."))
    
}
