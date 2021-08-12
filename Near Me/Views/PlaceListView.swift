//
//  PlaceListView.swift
//  Near Me
//
//  Created by Saksham Jain on 26/01/21.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    @Binding var search: String
    var landmarks: [Landmark]
    
    var body: some View {
        NavigationView {
            List (self.landmarks, id: \.id) { landmark in
                VStack(alignment: .leading) {
                    Text(landmark.name)
                        .font(.title2)
                    Text(landmark.title)
                        .font(.subheadline)
                }
                .padding()
            }.animation(.spring())
            .navigationTitle("\(search) near me")
        }
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(search: .constant("Test"), landmarks: [Landmark(placemark: MKPlacemark())])
    }
}
