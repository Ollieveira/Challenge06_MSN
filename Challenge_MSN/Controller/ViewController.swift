//
//  ViewController.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 11/02/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var buttonStatus: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let mockContacts: [Contact] = [
        Contact(profileImage: "profile1", username: "Alice", status: "Disponível", description: "Seja a mudança que você quer ver no mundo 🌎"),
        Contact(profileImage: "profile2", username: "Bob", status: "Ocupado", description: "Trabalhando... Não incomode 🚀"),
        Contact(profileImage: "profile3", username: "Charlie", status: "Ausente", description: "No mundo da lua 🌙"),
        Contact(profileImage: "profile4", username: "David", status: "Ocupado", description: "Codando até tarde 🖥️"),
        Contact(profileImage: "profile5", username: "Eve", status: "Offline", description: "Vendo séries 🎬"),
        Contact(profileImage: "profile6", username: "Frank", status: "Disponível", description: "Quem quer jogar alguma coisa? 🎮"),
        Contact(profileImage: "profile7", username: "Grace", status: "Ocupado", description: "Apenas vivendo um dia de cada vez 🍃"),
        Contact(profileImage: "profile8", username: "Hank", status: "Ausente", description: "Curtindo uma boa música 🎵"),
        Contact(profileImage: "profile9", username: "Ivy", status: "Disponível", description: "Sorria, a vida é curta 😁"),
        Contact(profileImage: "profile10", username: "Jack", status: "Offline", description: "Meditando... 🧘‍♂️")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        overrideUserInterfaceStyle = .light
        
        let xib = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "myID")
        // Do any additional setup after loading the view.
        
        configureStatusMenu()
        
        userProfile.image = UIImage(named: "userprofile")
        userProfile.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            deselectSelectedRow()
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
            
            cell.statusLabelViewConfig(status: contact.status)
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
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            print("Nenhuma célula selecionada")
            return
        }

        if let destination = segue.destination as? ChatViewController {
            let contact = mockContacts[selectedIndexPath.row]
            
            destination.name = contact.username
            destination.status = contact.status
            destination.profileImage = UIImage(named: contact.profileImage)
        } else {
            print("Destino desconhecido para o segue \(segue.identifier ?? "?")!")
        }

        
    }
    
    func configureStatusMenu() {
        let onlineAction = UIAction(title: "Online", image: UIImage(named: "iconMSNonline")) { _ in
            self.updateStatus(to: "Online")
        }
        
        let busyAction = UIAction(title: "Ausente", image: UIImage(named: "iconMSNbusy")) { _ in
            self.updateStatus(to: "Ausente")
        }
        
        let dndAction = UIAction(title: "Ocupado", image: UIImage(named: "iconMSNdonotdisturb")) { _ in
            self.updateStatus(to: "Ocupado")
        }
        
        let offlineAction = UIAction(title: "Offline", image: UIImage(named: "iconMSNoffline")) { _ in
            self.updateStatus(to: "Offline")
        }
        
        let statusMenu = UIMenu(title: "", children: [onlineAction, busyAction, dndAction, offlineAction])
        
        buttonStatus.menu = statusMenu
        buttonStatus.showsMenuAsPrimaryAction = true // Faz o botão abrir o menu diretamente
    }
    
    func updateStatus(to status: String) {
        
        func statusLabelViewConfig(status: String) {
            switch status {
            case "Online":
                statusImage.image = UIImage(named: "iconMSNonline")
            case "Ausente":
                statusImage.image = UIImage(named: "iconMSNbusy")
            case "Ocupado":
                statusImage.image = UIImage(named: "iconMSNdonotdisturb")
            case "Offline":
                statusImage.image = UIImage(named: "iconMSNoffline")
            default:
                break
            }
            
        }

        print("Status atualizado para: \(status)")
        buttonStatus.setTitle(status, for: .normal) // Atualiza o título do botão com o status selecionado
        statusLabelViewConfig(status: status)
    }
    
    private func deselectSelectedRow() {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    
    

}

