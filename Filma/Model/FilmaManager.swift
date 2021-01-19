//
//  FilmaManager.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import Foundation
import Alamofire
import SwiftyJSON


struct FilmaManager {
    
    let urlString = "https://jsonplaceholder.typicode.com"
    
    func fetchAlbums() {
        AF.request("\(urlString)/albums").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //debugPrint(json)
                for album in 0 ..< 100 {
                    let albumTitle = json[album]["title"].string
                    debugPrint(albumTitle ?? "")
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
