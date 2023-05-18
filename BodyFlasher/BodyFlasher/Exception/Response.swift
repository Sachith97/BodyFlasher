//
//  Response.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-18.
//

import Foundation

struct Response: Decodable {
    
    var isOk: Bool?
    var responseCode: Int?
    var responseMessage: String?
    
    init () { }
    
    init (isOk: Bool, responseCode: Int, responseMessage: String) {
        self.isOk = isOk
        self.responseCode = responseCode
        self.responseMessage = responseMessage
    }
}
