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
import SDWebImage

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionVC: UICollectionViewController {
    var selectedAlbum: Album?
    var photos = [Photo]()
    var searchedPhotos = [Photo]()
    var searching = false
    
    let filmaManager = FilmaManager()
    var searchBarManager = SearchBarManager()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        filmaManager.fetchPhotos()
        filmaManager.delegate = self
        searchBarManager.configurePhotoSearchController(searchController, navigationItem)
        searchController.searchBar.delegate = self
        collectionView.collectionViewLayout = searchBarManager.changeNumOfColumns(3)
    }

    // MARK: - CollectionView DataSource

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
        cell.image.sd_setImage(with: URL(string: photo.thumbnailUrl ?? ""))
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

        let columnLayout = searchBarManager.changeNumOfColumns(selectedScope)
        collectionView.collectionViewLayout = columnLayout
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
