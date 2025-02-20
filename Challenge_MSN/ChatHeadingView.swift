//
//  ChatHeadingView.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 20/02/25.
//
        
import UIKit
import AVFoundation

class ChatHeadingView: UIView {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var notificationIcon: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 25
        
        notificationIcon.addTarget(self, action: #selector(playAttentionSound), for: .touchUpInside)
    }

    

    func configure(name: String, status: String, profileImage: UIImage?) {
        
        usernameLabel?.text = name
        statusLabel?.text = status
        profileImageView?.image = profileImage
    }
    
    func statusLabelViewConfig(status: String) {
        switch status {
        case "Disponível":
            statusImageView.image = UIImage(named: "iconMSNonline")
        case "Ausente":
            statusImageView.image = UIImage(named: "iconMSNbusy")
        case "Ocupado":
            statusImageView.image = UIImage(named: "iconMSNdonotdisturb")
        case "Offline":
            statusImageView.image = UIImage(named: "iconMSNoffline")
        default:
            break
        }
    }
    
    @objc func playAttentionSound() {
        guard let soundURL = Bundle.main.url(forResource: "alert", withExtension: "mp3") else {
            print("⚠️ Erro: Arquivo de som não encontrado!")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("⚠️ Erro ao tentar reproduzir o som: \(error.localizedDescription)")
        }
    }


}
