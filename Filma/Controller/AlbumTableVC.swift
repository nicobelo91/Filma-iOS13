//
//  AlbumTableVC.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlbumTableVC: UITableViewController {

    var albums = [Album]()
    //let filmaManager = FilmaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //filmaManager.fetchAlbums()
        fetchAlbums()
    }
    
    func fetchAlbums() {
        AF.request("https://jsonplaceholder.typicode.com/albums").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for value in json.arrayValue {
                    let id = value.dictionaryValue["id"]!.int
                    let userId = value.dictionaryValue["userId"]!.int
                    let title = value.dictionaryValue["title"]!.string
                    
                    let album = Album(id: id, userId: userId, title: title)
                    self.albums.append(album)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Tableview Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPhoto", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotoCollectionVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedAlbum = albums[indexPath.row]
        }
    }

}
