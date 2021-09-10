//
//  ContentView.swift
//  Shared
//
//  Created by Ethan Zemelman on 2021-09-08.
//

import SwiftUI

struct ContentView: View {
    @State var cityName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("City Name", text: $cityName)
                    .padding(8)
                    .background(Color.black.opacity(0.08))
                    .cornerRadius(15)
                    .padding(10)
                Text("Weather: ")
            }.navigationTitle("Wethery")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// TODO: Create popup asking to access user location and automatically display weather for that location
