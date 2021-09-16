//
//  SearchLocationView.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-12.
//

import SwiftUI

struct SearchLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: ContentViewModel
    
    @Binding var location: String
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                TextField("Enter any location or zip code", text: $location)
                    .textContentType(.location)
                    .padding(8)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Button { viewModel.getWeather(for: location) } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                }
            }.padding()
            Spacer()
        }.alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }

    }
}

struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(viewModel: ContentViewModel(), location: .constant(""))
    }
}

//Button("Cancel") {
//    presentationMode.wrappedValue.dismiss()
//}
