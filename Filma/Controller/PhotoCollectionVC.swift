//
//  PhotoCollectionVC.swift
//  Filma
//
//  Created by Nico Cobelo on 20/01/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionVC: UICollectionViewController {
    var selectedAlbum: Album?
    var photos = [Photo]()
//    var filteredPhotos: [Photo] {
//        for photo in photos {
//            if selectedAlbum?.id == photo.albumId {
//                photos.append(photo)
//            }
//        }
//        return photos
//    }
    let filmaManager = FilmaManager()
    let columnLayout = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 10, minimumLineSpacing: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        collectionView.collectionViewLayout = columnLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //photos = selectedAlbum!.photos
    }
    
    func fetchPhotos() {
        AF.request("https://jsonplaceholder.typicode.com/photos").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for value in json.arrayValue {
                    let albbumId = value.dictionaryValue["albumId"]!.int
                    let id = value.dictionaryValue["id"]!.int
                    let title = value.dictionaryValue["title"]!.string
                    let url = value.dictionaryValue["url"]!.string
                    let thumbnailUrl = value.dictionaryValue["thumbnailUrl"]!.string
                    
                    let photo = Photo(albumId: albbumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)
                    if photo.albumId == self.selectedAlbum?.id {
                        self.photos.append(photo)
                    }
                }
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        let photo = photos[indexPath.item]
        cell.image.image = filmaManager.urlToImg(photo.url ?? "")
        cell.title.text = photo.title
    
        return cell
    }

}
