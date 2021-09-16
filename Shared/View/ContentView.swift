//
//  ContentView.swift
//  Shared
//
//  Created by Ethan Zemelman on 2021-09-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var showingSearchLocationView = false
    @State private var location = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 83/255, green: 81/255, blue: 230/255), Color(red: 105/255, green: 145/255, blue: 240/255), Color(red: 145/255, green: 195/255, blue: 247/255),]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button { showingSearchLocationView.toggle() } label: {
                        Image(systemName: "magnifyingglass")
                            .accentColor(.white)
                            .font(.title3)
                            .padding(.trailing, 10)
                    }
                    .padding(.trailing, 5)
                    .sheet(isPresented: $showingSearchLocationView) { SearchLocationView(viewModel: viewModel, location: $location) }
                }
                
                if let forecast = viewModel.forecast {
                    Text(viewModel.cityName)
                        .font(.title)
                        .padding(.top, 10)
                    
                    Text("\(forecast.current.weather[0].description.capitalized)")
                    
                    Text("\(forecast.current.temp, specifier: "%.1f")°")
                        .font(.system(size: 60, weight: .medium))
                    
                    HStack {
                        Text("\(forecast.daily[0].temp.max, specifier: "%.0f")° / \(forecast.daily[0].temp.min, specifier: "%.0f")°")
                            .padding(EdgeInsets(top: 3, leading: 7, bottom: 3, trailing: 7))
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                        
                        Text("Feels like \(forecast.current.feelsLike, specifier: "%.1f")°")
                            .padding(EdgeInsets(top: 3, leading: 7, bottom: 3, trailing: 7))
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                    }
                    
                } else {
                    Text("Enter a location to see weather.")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// TODO: Create popup asking to access user location and automatically display weather for that location
