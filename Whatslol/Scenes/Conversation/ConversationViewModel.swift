//
//  ConversationViewModel.swift
//  Whatslol
//
//  Created by Hélio Mesquita on 01/11/22.
//

import Foundation

protocol ConversationViewModelProtocol: AnyObject {
    func reloadData()
}

class ConversationViewModel {
    
    private let name: String
    private weak var delegate: ConversationViewModelProtocol?
    private let network: NetworkServiceProtocol
    private var messages: [MessageResponse] = []
    
    init(delegate: ConversationViewModelProtocol, name: String, network: NetworkServiceProtocol) {
        self.delegate = delegate
        self.name = name
        self.network = network
    }
    
    func getURL() -> URL {
        return URL(string: "https://us-central1-whatslol-1460f.cloudfunctions.net/\(name.lowercased())")!
    }
    
    func loadScreen() {
        network.performRequest(url: getURL(), responseModel: [MessageResponse].self) { response in
            self.messages = response
            self.delegate?.reloadData()
        } onFailure: { _ in
            self.delegate?.reloadData()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return messages.count
    }
    
    func messageForIndexPath(indexPath: IndexPath) -> MessageResponse {
        return messages[indexPath.row]
    }
    
    func cellIdentifier(indexPath: IndexPath) -> String {
        if messages[indexPath.row].itsMe {
            return "leftCell"
        } else {
            return "rightCell"
        }
    }

}

