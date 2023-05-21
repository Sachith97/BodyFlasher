//
//  Response.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-18.
//

import Foundation

struct Response: Decodable {
    
    var ok: Bool?
    var responseCode: Int?
    var responseMessage: String?
    
    init () { }
    
    init (ok: Bool, responseCode: Int, responseMessage: String) {
        self.ok = ok
        self.responseCode = responseCode
        self.responseMessage = responseMessage
    }
}
