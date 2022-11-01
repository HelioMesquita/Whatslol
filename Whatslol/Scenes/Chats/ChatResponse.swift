//
//  ChatResponse.swift
//  Whatslol
//
//  Created by Hélio Mesquita on 18/10/22.
//

import Foundation

class ChatResponse: Decodable {
    
    let profileImage: URL
    let name: String
    let lastMessage: String
    let hasVisualized: Bool
    let lastMessageDate: String
    let profile: URL
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "imagemPerfil"
        case name = "nome"
        case lastMessage = "ultimaMensagem"
        case hasVisualized = "foiVisualizado"
        case lastMessageDate = "dataUltimaMensagem"
        case profile = "perfil"
    }
    
    init(
        profileImage: URL,
        name: String,
        lastMessage: String,
        hasVisualized: Bool,
        lastMessageDate: String,
        profile: URL
    ) {
        self.profileImage = profileImage
        self.name = name
        self.lastMessage = lastMessage
        self.hasVisualized = hasVisualized
        self.lastMessageDate = lastMessageDate
        self.profile = profile
    }

}
