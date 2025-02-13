//
//  ViewController.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 11/02/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let mockContacts: [Contact] = [
        Contact(profileImage: "profile1", username: "Alice", status: "Disponível", description: "Seja a mudança que você quer ver no mundo 🌎"),
        Contact(profileImage: "profile2", username: "Bob", status: "Ocupado", description: "Trabalhando... Não incomode 🚀"),
        Contact(profileImage: "profile3", username: "Charlie", status: "Ausente", description: "No mundo da lua 🌙"),
        Contact(profileImage: "profile4", username: "David", status: "Trabalhando", description: "Codando até tarde 🖥️"),
        Contact(profileImage: "profile5", username: "Eve", status: "Offline", description: "Vendo séries 🎬"),
        Contact(profileImage: "profile6", username: "Frank", status: "Disponível", description: "Quem quer jogar alguma coisa? 🎮"),
        Contact(profileImage: "profile7", username: "Grace", status: "Ocupado", description: "Apenas vivendo um dia de cada vez 🍃"),
        Contact(profileImage: "profile8", username: "Hank", status: "Ausente", description: "Curtindo uma boa música 🎵"),
        Contact(profileImage: "profile9", username: "Ivy", status: "Disponível", description: "Sorria, a vida é curta 😁"),
        Contact(profileImage: "profile10", username: "Jack", status: "Offline", description: "Meditando... 🧘‍♂️")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tableView == nil {
            print("⚠️ Erro: tableView não está conectada no Storyboard/XIB.")
        } else {
            print("✅ tableView conectada corretamente.")
        }

        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "myID")
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockContacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myID", for: indexPath)
        let contact = mockContacts[indexPath.row]
        
        if let cell = cell as? ContactsTableViewCell {
            cell.namelabel.text = contact.username
            cell.statusLabelView.text = contact.status
            cell.dailyMessageLabel.text = contact.description
            cell.profileImageView.image = UIImage(named: contact.profileImage)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chat", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            print("Nenhuma célula selecionada")
            return
        }
        
        if let destination = segue.destination as? ChatViewController {
            destination.name = mockContacts[selectedIndexPath.row].username
        } else {
            print("Destino desconhecido para o segue \(segue.identifier ?? "?")!")
        }
        
    }
    
}

