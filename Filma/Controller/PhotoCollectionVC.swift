//
//  PhotoCollectionVC.swift
//  Filma
//
//  Created by Nico Cobelo on 20/01/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import ChameleonFramework

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionVC: UICollectionViewController {
    var selectedAlbum: Album?
    var photos = [Photo]()
    var searchedPhotos = [Photo]()
    var searching = false
    let filmaManager = FilmaManager()
    var columnLayout: ColumnFlowLayout?
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        filmaManager.fetchPhotos()
        filmaManager.delegate = self
        configureSearchController()
        collectionView.collectionViewLayout = columnLayout ?? ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 0, minimumLineSpacing: 0)
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photos"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["1 Column", "2 Columns", "3 Columns"]
        searchController.searchBar.selectedScopeButtonIndex = 2
        searchController.searchBar.delegate = self
        
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searchedPhotos.count
        } else {
            return photos.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        var photo: Photo {
            if searching {
                return searchedPhotos[indexPath.item]
            } else {
                return photos[indexPath.item]
            }
        }
        cell.image.image = filmaManager.urlToImg(photo.thumbnailUrl ?? "")
        cell.title.text = photo.title
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotoDetailVC
        
        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            let photo = photos[indexPath.item]
            destinationVC.selectedPhoto = photo
        }
    }
}
// MARK: - SearchBar Delegate

extension PhotoCollectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedPhotos = photos.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

            switch selectedScope {
            case 0:
                columnLayout = ColumnFlowLayout(cellsPerRow: 1, minimumInteritemSpacing: 0, minimumLineSpacing: 0)
            case 1:
                columnLayout = ColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 0, minimumLineSpacing: 0)
            default:
                columnLayout = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 0, minimumLineSpacing: 0)
            }
        collectionView.collectionViewLayout = columnLayout!
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        collectionView.reloadData()
    }
}

// MARK: - FilmaManager Delegate

extension PhotoCollectionVC: FilmaManagerDelegate {
    func didAppendPhoto(_ filmaManager: FilmaManager, _ photo: Photo) {
        if photo.albumId == self.selectedAlbum?.id {
            self.photos.append(photo)
        }
    }
    
    func didUpdateData(_ filmaManager: FilmaManager) {
        self.collectionView.reloadData()
    }
}
