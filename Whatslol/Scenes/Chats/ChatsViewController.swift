//
//  ChatsViewController.swift
//  fastLearning
//
//  Created by Luis Gustavo Fermino Moraes on 28/09/22.
//

import UIKit

class ChatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chats: [ChatResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://us-central1-whatslol-1460f.cloudfunctions.net/chat")!
        NetworkService.performRequest(url: url, responseModel: [ChatResponse].self) { response in
            self.chats = response
            self.tableView.reloadData()
        } onFailure: { _ in
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "whatsappCell", for: indexPath) as! ChatTableViewCell
        let chat = chats[indexPath.row]
        cell.setValues(chat: chat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = chats[indexPath.row]
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

