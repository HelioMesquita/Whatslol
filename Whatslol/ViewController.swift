//
//  ViewController.swift
//  fastLearning
//
//  Created by Luis Gustavo Fermino Moraes on 28/09/22.
//

import UIKit

class Chat: Decodable {
    
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
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chats: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://us-central1-whatslol-1460f.cloudfunctions.net/chat")!
        let urlRequest = URLRequest(url: url)
        
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
                do {
                    let decodeObject = try JSONDecoder().decode([Chat].self, from: data ?? Data())
                    self.chats = decodeObject
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
                
            }.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "whatsappCell", for: indexPath) as! WhatsAppCellTableViewCell
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
            guard let chat = sender as? Chat, let viewController = segue.destination as? ConversationTableViewController else {
                return
            }
            viewController.chat = chat
        }
    }

}

