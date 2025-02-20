//
//  ChatViewController.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 13/02/25.
//

import UIKit

class ChatViewController: UIViewController {
    
    var name: String?
    var status: String?
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        guard let headerView = Bundle.main.loadNibNamed("ChatHeadingView", owner: self, options: nil)?.first as? ChatHeadingView else {
            return
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Configura os dados do contato no header
        headerView.configure(name: name ?? "Usuário", status: status ?? "Offline", profileImage: profileImage)
        
        headerView.statusLabelViewConfig(status: status ?? "Offline")
        
        self.view.addSubview(headerView)

        
        
        
        // Adiciona a view ao topo da tela
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // Adiciona ação ao botão de voltar
        headerView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

