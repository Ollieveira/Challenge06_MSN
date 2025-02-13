//
//  ChatViewController.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 13/02/25.
//

import UIKit

class ChatViewController: UIViewController {

    var name: String?
    @IBOutlet weak var chatUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name {
            self.chatUsername.text = name
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
