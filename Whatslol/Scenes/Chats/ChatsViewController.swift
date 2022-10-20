//
//  ChatsViewController.swift
//  fastLearning
//
//  Created by Luis Gustavo Fermino Moraes on 28/09/22.
//

import UIKit

class ChatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = ChatsViewModel(delegate: self, network: NetworkService())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.loadScreen()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "whatsappCell", for: indexPath) as! ChatTableViewCell
        let chat = viewModel.chatForIndexPath(indexPath: indexPath)
        cell.setValues(chat: chat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = viewModel.chatForIndexPath(indexPath: indexPath)
        performSegue(withIdentifier: "showChat", sender: chat)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChat" {
            guard let chat = sender as? ChatResponse, let viewController = segue.destination as? ConversationViewController else {
                return
            }
            viewController.chat = chat
        }
    }
    
}

extension ChatsViewController: ChatsViewModelProtocol {
    
    func reloadData() {
        self.tableView.reloadData()
    }

}

