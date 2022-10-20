//
//  ChatsViewModel.swift
//  Whatslol
//
//  Created by Hélio Mesquita on 20/10/22.
//

import Foundation

protocol ChatsViewModelProtocol: AnyObject {
    func reloadData()
}

class ChatsViewModel {
    
    private let url = URL(string: "https://us-central1-whatslol-1460f.cloudfunctions.net/chat")!
    private weak var delegate: ChatsViewModelProtocol?
    private let network: NetworkServiceProtocol
    private var chats: [ChatResponse] = []
    
    init(delegate: ChatsViewModelProtocol, network: NetworkServiceProtocol) {
        self.delegate = delegate
        self.network = network
    }
    
    func loadScreen() {
        network.performRequest(url: url, responseModel: [ChatResponse].self) { response in
            self.chats = response
            self.delegate?.reloadData()
        } onFailure: { _ in
            self.delegate?.reloadData()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return chats.count
    }
    
    func chatForIndexPath(indexPath: IndexPath) -> ChatResponse {
        return chats[indexPath.row]
    }


}
