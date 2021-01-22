//
//  AlbumTableVC.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import ChameleonFramework

class AlbumTableVC: UITableViewController {

    var albums = [Album]()
    var searchedAlbums = [Album]()
    var filmaManager = FilmaManager()
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        filmaManager.delegate = self
        filmaManager.fetchAlbums()
    }
    
    // MARK: - Tableview Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedAlbums.count
        } else {
            return albums.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        var album: Album {
            if searching {
                return searchedAlbums[indexPath.row]
            } else {
                return albums[indexPath.row]
            }
        }
        //
        cell.textLabel?.text = album.title
        if let color = HexColor("#C9ECFD")?.darken(byPercentage: CGFloat(indexPath.row) / 500) {
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        
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
            if searching {
                destinationVC.selectedAlbum = searchedAlbums[indexPath.row]
            } else {
                destinationVC.selectedAlbum = albums[indexPath.row]
            }
        }
    }
}

// MARK: - SearchBar Delegate
extension AlbumTableVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedAlbums = albums.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Albums"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
    }
}

// MARK: - FilmaManager Delegate
extension AlbumTableVC: FilmaManagerDelegate {
    func didAppendAlbum(_ filmaManager: FilmaManager, _ album: Album) {
        self.albums.append(album)
    }
    
    func didUpdateData(_ filmaManager: FilmaManager) {
        tableView.reloadData()
    }
}
