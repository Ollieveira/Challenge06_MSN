//
//  ChatViewController.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 13/02/25.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var messages: [Message] = []
    
    // Criando os elementos da interface via código
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
        return table
    }()
    
    private let messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite uma mensagem..."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

        
    var name: String?
    var status: String?
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        // Esconder teclado ao tocar na tela
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Configuração da Interface

    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
        
        tableView.separatorStyle = .none // Remove as linhas entre as mensagens
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints da tabela (ocupa toda a tela, exceto a parte inferior)
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -8),

            // Constraints do TextField
            messageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            messageTextField.heightAnchor.constraint(equalToConstant: 40),

            // Constraints do botão de enviar
            sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

    // MARK: - Métodos do TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        let message = messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = message.isSentByUser ? .right : .left
        
        return cell
    }

    // MARK: - Envio de Mensagens

    @objc private func sendMessage() {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        
        let newMessage = Message(text: text, isSentByUser: true)
        messages.append(newMessage)

        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.scrollToBottom()
        }
        
        messageTextField.text = ""
    }

    private func scrollToBottom() {
        if messages.count > 0 {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

}

