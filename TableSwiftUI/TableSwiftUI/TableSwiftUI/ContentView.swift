//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by D'Andrea, Rachel E on 3/31/25.
//

import SwiftUI

import MapKit

let data = [
    Item(name: "Red Yucca", Genus: "Hesperaloe parviflora", desc: "With its graceful, arching leaves and breathtaking fiery red flower spikes, Red Yucca adds a touch of Southwestern charm to any landscape.", lat: 29.7132, long: -98.1264, imageName: "redyucca2"),
    
    Item(name: "Coral Honeysuckle", Genus: "Lonicera", desc: "Clump-forming vine. Great species for hummingbirds. The red flowers are prolific for about a month in May/June followed by sporadic flowering the rest of the season.", lat: 29.6221, long: -98.0246, imageName: "coralhoneysuckle2"),
    
    Item(name: "Flame Acanthus", Genus: "Anisacanthus", desc: "The Flame Acanthus is a deciduous Texas native shrub best known for its red tubular flowers that are beloved by hummingbirds.", lat: 29.6977, long: -98.1074, imageName: "flameacanthus2"),
    
    Item(name: "Four-Nerve Daisy", Genus: "Hymenoxys; Cass", desc: "This Texas native perennial has long narrow leaves of gray-green foliage that form a clump from which the flower stems arise. When in full bloom, Four Nerve Daisy can appear covered with flowers and the individual flowers are long lasting.", lat: 29.6306, long: -98.1034, imageName: "fournervedaisy"),
    
    Item(name: "Snakeherb", Genus: "Dyschoriste", desc: "perennial plant with lavender to purple flowers that bloom in late spring and early summer.", lat: 29.7026, long: -98.1255, imageName: "snakeherb2")
]

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let Genus: String
    let desc: String
    let lat: Double
    let long: Double
    let imageName: String
}


struct ContentView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.7026, longitude: -98.1255), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 30)
                List(data, id: \.name) { item in
                    
                    
                    NavigationLink(destination: DetailView(item: item)) {
                    
                    
                    
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit() //
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        
                    VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                                .lineLimit(1)
                            Text(item.Genus)
                                .font(.subheadline)
                        } // end internal VStack
                    } // end HStack
                    .padding(.vertical, 8.5)
                    } // end NavigationLink
                    .listRowBackground(Color.green.opacity(0.2))
                } // end List
             
           
                
                Map(coordinateRegion: $region, annotationItems: data) { item in
                              MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                  Image(systemName: "mappin.circle.fill")
                                      .foregroundColor(.red)
                                      .font(.title)
                                      .overlay(
                                          Text(item.name)
                                              .font(.subheadline)
                                              .foregroundColor(.black)
                                              .fixedSize(horizontal: true, vertical: false)
                                              .offset(y: 25)
                                      )
                              }
                          } // end map
                         .frame(height: 300)
                          .padding(.bottom, -30)
                          
                
                
            } // end VStack
            .background(Color.yellow.opacity(0.2))
        
      
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Native Plants")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("in New Braunfels")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                               }
                           }
                } // end NavigationView
        } // end body
}




struct DetailView: View {
    
    @State private var region: MKCoordinateRegion
       
       init(item: Item) {
           self.item = item
           _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)))
       }
    
        let item: Item
                
        var body: some View {
            VStack {
        
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                
                Text(item.name)
                       .font(.title)  // Larger font for the name
                       .padding(.top, 10)
                
                Text("Genus: \(item.Genus)")
                    .font(.subheadline)
                    .padding(.top, 10)
                
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(10)
                
                //Spacer().frame(height: 40)
                
                
                
                Map(coordinateRegion: $region, annotationItems: [item]) { item in
                     MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                         Image(systemName: "mappin.circle.fill")
                             .foregroundColor(.red)
                             .font(.title)
                             .overlay(
                                 Text(item.name)
                                     .font(.subheadline)
                                     .foregroundColor(.black)
                                     .fixedSize(horizontal: true, vertical: false)
                                     .offset(y: 25)
                             )
                     }
                 } // end Map
                     .frame(height: 300)
                    .padding(.bottom, -30)
                   
                
                
                
                    } // end VStack
            .padding(.top, 20) // Adds padding from the top (above the navigation bar)
            .background(Color.green.opacity(0.2)) // Light green background for the entire VStack
            .edgesIgnoringSafeArea([.top, .bottom]) // Ensures background extends behind title and map
           // .navigationTitle(item.name) // Display the item name as the title
            //.navigationBarTitleDisplayMode(.inline) // Keeps the title inline
                   
                    
                   
                 
         } // end body
      } // end DetailView
    






#Preview {
    ContentView()
}
