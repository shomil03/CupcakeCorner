//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Paul Hudson on 11/11/2023.
//

import SwiftUI

struct CheckoutView: View {
    var order : Order
    @State private var showingConfirmation : Bool = false
    @State private var confirmationMessage = ""
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
                    Task{
                        await NetworkManager()
                    }
                }
            }
            .alert("ThankYou!!", isPresented: $showingConfirmation){
                
            } message: {
                Text(confirmationMessage)
            }
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }.scrollBounceBehavior(.basedOnSize)
    }
    func NetworkManager() async{
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Cannot encode data")
            return
        }
        let url = URL(string: "https://reqres.in/api/users")
        guard let url = url else{
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let (data , _) = try await URLSession.shared.upload(
                for: request, from: encoded)
            print(data)
            
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decoded.quantity)x \(Order.types[decoded.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
            
        }catch{
            print("error \(error.localizedDescription)")
            return
        }
        
    }
}

#Preview {
    CheckoutView(order: Order())
}
