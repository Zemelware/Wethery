//
//  SearchLocationView.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-12.
//

import SwiftUI

struct SearchLocationView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: ContentViewModel
    
    @Binding var location: String
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter any location or zip code", text: $location)
                    .textContentType(.location)
                    .padding(8)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .submitLabel(.search)
                    .onSubmit {
                        viewModel.getWeather(for: location) { locationIsValid in
                            if locationIsValid {
                                dismiss()
                            }
                        }
                    }
                
                Button("Cancel", role: .cancel) { dismiss() }
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
