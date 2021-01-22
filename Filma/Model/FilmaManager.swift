//
//  FilmaManager.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol FilmaManagerDelegate {
    func didAppendAlbum(_ filmaManager: FilmaManager, _ album: Album)
    func didAppendPhoto(_ filmaManager: FilmaManager, _ photo: Photo)
    func didUpdateData(_ filmaManager: FilmaManager)
}

class FilmaManager {
    
    let urlString = "https://jsonplaceholder.typicode.com"
    var albums = [Album]()
    
    var delegate: FilmaManagerDelegate?
    
    func fetchAlbums() {
        AF.request("\(urlString)/albums").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for value in json.arrayValue {
                    let id = value.dictionaryValue["id"]!.int
                    let userId = value.dictionaryValue["userId"]!.int
                    let title = value.dictionaryValue["title"]!.string
                    
                    let album = Album(id: id, userId: userId, title: title)
//                    self.albums.append(album)
                    self.delegate?.didAppendAlbum(self, album)
                }
                //self.tableView.reloadData()
                self.delegate?.didUpdateData(self)
                
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func fetchPhotos() {
        AF.request("\(urlString)/photos").responseJSON { (response) in
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
//                    if photo.albumId == self.selectedAlbum?.id {
//                        self.photos.append(photo)
//                    }
                    self.delegate?.didAppendPhoto(self, photo)
                }
                //self.collectionView.reloadData()
                self.delegate?.didUpdateData(self)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FilmaManagerDelegate {
    func didAppendAlbum(_ filmaManager: FilmaManager, _ album: Album) {
    }
    func didAppendPhoto(_ filmaManager: FilmaManager, _ photo: Photo) {
    }
}
