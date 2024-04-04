//
//  MainViewController.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/3/24.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    
    private let fredjorZonePj = ["Ashe", "Anivia", "Volibear", "Lissandra", "Trydamere", "Sejuani", "Trundle", "Udyr", "Ornn", "Gnar", "Braum"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       // tableView.register(UINib(nibName: "RedditTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
    }


}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        fredjorZonePj.count
    } //Pa que return si es una sola linea
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
        }
        cell!.textLabel?.text = fredjorZonePj[indexPath.row]
        
        return cell!
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
