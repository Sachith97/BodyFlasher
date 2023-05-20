//
//  LoginResponse.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-19.
//

import Foundation

struct LoginResponse: Decodable {
    
    var ok: Bool?
    var responseCode: Int?
    var responseMessage: String?
    var responseObject: LoginResponseDetail?
    
    init () { }
    
    init (ok: Bool, responseCode: Int, responseMessage: String, responseObject: LoginResponseDetail) {
        self.ok = ok
        self.responseCode = responseCode
        self.responseMessage = responseMessage
        self.responseObject = responseObject
    }
}
