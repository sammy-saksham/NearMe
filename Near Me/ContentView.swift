//
//  ContentView.swift
//  Near Me
//
//  Created by Saksham Jain on 26/01/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    private var locationManager = LocationManager()
    
    @State private var search: String = ""
    @State private var landmarks = [Landmark]()
    @State var tapped: Bool = false
    @State var isEditing: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gray]
    }
    
    private func getNearByLandmarks() {
        
        guard let location = self.locationManager.location else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response, error == nil else {
                return
            }
            
            let mapItems = response.mapItems
            self.landmarks = mapItems.map {
                Landmark(placemark: $0.placemark)
            }
            
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                
                MapView(landmarks: self.landmarks)
                    .ignoresSafeArea()
                
                HStack{
                    
                    TextField("Search", text: self.$search, onEditingChanged: { _ in }) {
                        self.getNearByLandmarks()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title2)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .animation(.default)
                    
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.search = ""
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.gray)
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                .padding()
                
            }
            .navigationTitle(Text("Near Me"))
            .navigationBarItems(trailing:
                Button("Show List", action: {
                    self.tapped.toggle()
                })
            )
            
        }
        .sheet(isPresented: self.$tapped, content: {
            PlaceListView(search: $search, landmarks: self.landmarks)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
