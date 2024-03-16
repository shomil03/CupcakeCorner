//
//  Order.swift
//  CupcakeCorner
//
//  Created by Shomil Singh on 13/03/24.
//

import Foundation
import SwiftUI
@Observable
class Order: Codable {
    enum CodingKeys : String, CodingKey{
        case _zip = "zip"
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequest = "SpecialRequest"
        case _extraFrosting = "extraFrosting"
        case _addSprinkes = "addSprinkes"
        case _name = "name"
        case _city = "city"
    }
    static let types = ["Vanilla" , "Chocolate" , "Strawberry" , "Rainbow"]
    var AlertItem : AlertItem?
    var isShowingAlert : Bool = false
    var type = 0
    var quantity = 1
    var cureentFeedback : SensoryFeedback = .success
    var specialRequest = false{
        didSet{
            extraFrosting = specialRequest && extraFrosting
            addSprinkes = specialRequest && addSprinkes
        }
    }
    
    var extraFrosting = false
    
    var addSprinkes = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    var disables : Bool{
        if(name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty)
        {
            return true
        }
        return false
    }
    
    func isValid() -> Bool{
        name = name.trimmingCharacters(in: [" "])
        streetAddress = streetAddress.trimmingCharacters(in: .whitespaces)
        city = city.trimmingCharacters(in: .whitespaces)
        zip = zip.trimmingCharacters(in: .whitespaces)
        
        return disables
    }
    
    func save(){
        UserDefaults.standard.setValue([name , streetAddress , city , zip], forKey: "UserData")
    }

    func loadData(){
        let arr = UserDefaults.standard.array(forKey: "UserData") ?? ["" , "" ,"" ,""]
        name = arr[0] as! String
        streetAddress = arr[1] as! String
        city = arr[2] as! String
        zip = arr[3] as! String
    }
    
    
    var cost : Decimal{
        var total = Decimal(quantity) * 65
        total += 15 * Decimal(type)
        
        if(extraFrosting){
            total += 25
        }
        if(addSprinkes){
            total += 15
        }
        return total
    }
}
