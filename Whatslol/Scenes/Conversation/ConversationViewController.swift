//
//  ConversationViewController.swift
//  fastLearning
//
//  Created by Luis Gustavo Fermino Moraes on 06/10/22.
//

import UIKit

class ConversationViewController: UITableViewController {
    
    var chat: ChatResponse?
    var messages: [MessageResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        guard let name = chat?.name else{ return }
        self.title = name
        
        let url = URL(string: "https://us-central1-whatslol-1460f.cloudfunctions.net/\(name.lowercased())")!
        
        NetworkService.performRequest(url: url, responseModel: [MessageResponse].self) { response in
            self.messages = response
            self.tableView.reloadData()
        } onFailure: { _ in
            self.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.itsMe {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath) as? MessageTableViewCell else {
                return UITableViewCell()
            }
            cell.messageLabel.text = message.message
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "rightCell", for: indexPath) as? MessageTableViewCell else {
                return UITableViewCell()
            }
            cell.messageLabel.text = message.message
            return cell
        }
    }
    
}
