//
//  ViewController.swift
//  Challenge_MSN
//
//  Created by Willys Oliveira on 11/02/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myID", for: indexPath)
        as! ContactsTableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let xib = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "myID")
        // Do any additional setup after loading the view.
    }


}

