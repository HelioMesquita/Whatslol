//
//  ConversationViewController.swift
//  fastLearning
//
//  Created by Luis Gustavo Fermino Moraes on 06/10/22.
//

import UIKit

class ConversationViewController: UITableViewController, ConversationViewModelProtocol {
    
    var chat: ChatResponse?
    lazy var viewModel: ConversationViewModel = ConversationViewModel(delegate: self, name: chat?.name ?? "", network: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.title = chat?.name
        viewModel.loadScreen()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messageForIndexPath(indexPath: indexPath)
        let identifier = viewModel.cellIdentifier(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MessageTableViewCell
        cell?.messageLabel.text = message.message
        return cell ?? UITableViewCell()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}
