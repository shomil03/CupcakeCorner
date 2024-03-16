//
//  NetworkMAnager.swift
//  CupcakeCorner
//
//  Created by Shomil Singh on 16/03/24.
//

import Foundation
import SwiftUI

class NetworkManager{
    static var shared = NetworkManager()
    var decoded = Order()
    func NetworkCall(order : Order) async{
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
            
            decoded = try JSONDecoder().decode(Order.self, from: data)
            order.AlertItem = AlertContext.success
            order.isShowingAlert = true
            order.cureentFeedback = .success
            
        }catch{
            print("this error \(error.localizedDescription)")
            order.AlertItem = AlertContext.failure
            order.isShowingAlert = true
            order.cureentFeedback = .error
            
            return
        }
        
    }
    
}
