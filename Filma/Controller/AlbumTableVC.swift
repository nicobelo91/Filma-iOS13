//
//  AlbumTableVC.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import UIKit

class AlbumTableVC: UITableViewController {

    let albums = [Album]()
    let filmaManager = FilmaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.name
        
        return cell
    }

}
