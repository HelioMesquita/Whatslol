//
//  MessageResponse.swift
//  Whatslol
//
//  Created by Hélio Mesquita on 18/10/22.
//

import Foundation

class MessageResponse: Decodable {
    
    let message: String
    let itsMe: Bool
    
    enum CodingKeys: String, CodingKey {
        case message = "mensagem"
        case itsMe = "souEu"
    }
}
