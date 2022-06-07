//
//  Application.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 05.03.2021.
//

import Foundation

struct Application: Encodable {
    var name: String
    var phoneNumber: String
    var address: String
    var orderType: String?
    var serviceType: String?
    var comment: String?
    var date: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "your-name"
        case phoneNumber = "tel-532"
        case address = "textarea-432"
        case orderType = "menu-519"
        case serviceType = "menu-142"
        case comment = "textarea-433"
        case date = "date-79"
    }
    
    init(name: String, phoneNumber: String, address: String, orderType: String? = nil, serviceType: String? = nil, comment: String? = nil, date: String? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.orderType = orderType
        self.serviceType = serviceType
        self.comment = comment
        self.date = date
    }
}
