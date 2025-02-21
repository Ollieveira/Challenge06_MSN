//
//  ChatViewController.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 13/02/25.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var messages: [Message] = []
    
    private var textFieldBottomConstraint: NSLayoutConstraint!
    private var sendButtonBottomConstraint: NSLayoutConstraint!
    
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
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1) // Cinza claro
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Adicionando espaçamento interno para o texto não colar na borda
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        textField.leftViewMode = .always
        
        return textField
    }()

    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
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
        
        // Observadores para quando o teclado aparece e desaparece
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        overrideUserInterfaceStyle = .light

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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            
            UIView.animate(withDuration: 0.3) {
                self.textFieldBottomConstraint.constant = -keyboardHeight + self.view.safeAreaInsets.bottom - 8
                self.sendButtonBottomConstraint.constant = -keyboardHeight + self.view.safeAreaInsets.bottom - 8
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.textFieldBottomConstraint.constant = -8
            self.sendButtonBottomConstraint.constant = -8
            self.view.layoutIfNeeded()
        }
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
        textFieldBottomConstraint = messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        sendButtonBottomConstraint = sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)

        NSLayoutConstraint.activate([
            // Constraints da tabela (mantém a área da tableView fixa)
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -8),

            // Constraints do TextField
            messageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            textFieldBottomConstraint,
            messageTextField.heightAnchor.constraint(equalToConstant: 40),

            // Constraints do botão de enviar
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sendButton.widthAnchor.constraint(equalToConstant: 70),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor),
            sendButtonBottomConstraint
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

