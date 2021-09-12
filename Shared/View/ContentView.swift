//
//  ContentView.swift
//  Shared
//
//  Created by Ethan Zemelman on 2021-09-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var location = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Location", text: $location)
                        .padding(8)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(15)
                        .padding(.leading, 10)
                    Button { viewModel.getWeather(for: location) } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                            .padding(.trailing, 10)
                    }
                }
                if let forecast = viewModel.forecast {
                    Text("Weather: \(forecast.current.temp)")
                }
                
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
