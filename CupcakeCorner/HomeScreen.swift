//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Shomil Singh on 12/03/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var order = Order()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices ,id:\.self){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes \(order.quantity)", value: $order.quantity , in: 1...20)
                }
                Section{
                    Toggle("Any special request?", isOn: $order.specialRequest)
                    if order.specialRequest{
                        Toggle("Add extra frosting" , isOn: $order.extraFrosting)
                        Toggle("Add Sprinkers", isOn: $order.addSprinkes)
                        
                        
                    }
                }
                NavigationLink("Delivery Details"){
                    AddressView(order: order)
                }
                .navigationTitle("Cupcake Corner")
            }
        }
    
    }
}

#Preview {
    HomeScreen()
}
