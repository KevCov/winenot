//
//  ViewController.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 4/12/25.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tramites = ["Hola Mundo", "Como están"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        profileButton.setText(text: "Visualizar Perfil")
        profileButton.setBorder(color: .purple, width: 2.0)
        profileButton.setBackgroundColor(color: .purple)
        profileButton.setRadius(radius: 10.0)
        
        profileImageView.setImage(name: "usuario")
    }

}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tramites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let indice = indexPath.row
        let tramite=tramites[indice]
        
        var content = cell.defaultContentConfiguration()
        content.text = tramite
        cell.contentConfiguration = content
        //cell.textLabel?.text = tramite
        //cell.updateCell(model: tramite)
        return cell
    }
    
}
