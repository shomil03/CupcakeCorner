//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Paul Hudson on 10/11/2023.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order : Order

    var body: some View {
        
        NavigationStack {
            VStack{
                Form{
                    Section{
                        TextField("Name", text: $order.name)
                        TextField("Stree Address", text: $order.streetAddress)
                        TextField("City", text: $order.city)
                        TextField("Zip", text: $order.zip)
                    }
                    Section{
                        NavigationLink("Check Out"){
                            CheckoutView(order: order)
                        }
                    }
                    .disabled(order.disables)
                }.navigationTitle("Delivery Details")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
   
}

#Preview {
    AddressView(order: Order())
}
