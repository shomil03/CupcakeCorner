//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Paul Hudson on 10/11/2023.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order : Order
    @FocusState var focused : SelectedTextField?
    enum SelectedTextField{
        case name , streetAddress , city , Zip
    }

    var body: some View {
        
        NavigationStack {
            VStack{
                Form{
                    Section{
                        TextField("Name", text: $order.name)
                            .focused($focused, equals: .name)
                            .onSubmit() {
                                focused = .streetAddress
                            }
                            .submitLabel(.continue)
                        
                        TextField("Street Address", text: $order.streetAddress)
                            .focused($focused, equals: .streetAddress)
                            .onSubmit() {
                                focused = .city
                            }
                            .submitLabel(.continue)
                        
                        TextField("City", text: $order.city)
                            .focused($focused, equals: .city)
                            .onSubmit() {
                                focused = .Zip
                            }
                            .submitLabel(.continue)
                        
                        TextField("Zip", text: $order.zip)
                            .focused($focused , equals: .Zip)
                            .onSubmit {
                                focused = nil
                            }
                            
                    }
                    
                    Section{
                        NavigationLink("Check Out"){
                            
                                CheckoutView(order: order)
                        }
                    }
                    .disabled(order.isValid())
                }.navigationTitle("Delivery Details")
                    .navigationBarTitleDisplayMode(.inline)
                
                    .onAppear{
                        order.loadData()
                    }
            }
        }
    }
   
}

#Preview {
    AddressView(order: Order())
}
