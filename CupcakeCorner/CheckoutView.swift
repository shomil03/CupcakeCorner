//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Paul Hudson on 11/11/2023.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order : Order
    @State private var tapped : Bool = true
    var body: some View {
        ScrollView{
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),scale: 3){phase in
                        if let image = phase.image{
                            image
                                .resizable()
                                .scaledToFit()
                        }else if phase.error != nil{
                            Color.red
                        }
                    else{
                        ProgressView()
                    }
                }
                .frame(height: 233)
                Text("Your total sum is  \(order.cost , format: .currency(code:"INR"))")
                    .font(.title)
                Spacer()
                Button("Pay Now"){
                    tapped.toggle()
                    Task{
                        await NetworkManager.shared.NetworkCall(order:order)
                    }
                }
                
            }
            .alert(order.AlertItem?.title ?? Text(""), isPresented: $order.isShowingAlert, actions: {}, message: {order.AlertItem?.message})
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
            .sensoryFeedback(order.cureentFeedback, trigger: tapped)
            
            
        }.scrollBounceBehavior(.basedOnSize)
    }
    
}

#Preview {
    CheckoutView(order: Order())
}
