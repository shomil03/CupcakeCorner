//
//  Alerts.swift
//  CupcakeCorner
//
//  Created by Shomil Singh on 16/03/24.
//

import Foundation
import SwiftUI
struct AlertItem : Identifiable{
    let id = UUID()
    let title : Text
    let message : Text
}
struct AlertContext{
    static let success = AlertItem(title: Text("ThankYOU!!!"),
                               message: Text("Your order for \(NetworkManager.shared.decoded.quantity)x \(Order.types[NetworkManager.shared.decoded.type].lowercased()) cupcakes is on the way!" ))
    static let failure = AlertItem(title: Text("There was an error") ,
                              message: Text("Try Again!"))
}
