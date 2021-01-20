//
//  FilmaManager.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import UIKit
import Alamofire
import SwiftyJSON


class FilmaManager {
    
    let urlString = "https://jsonplaceholder.typicode.com"
    var albums = [Album]()
    func fetchAlbums(_ tableView: UITableView) {
        AF.request("\(urlString)/albums").responseJSON { (response) in
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
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
