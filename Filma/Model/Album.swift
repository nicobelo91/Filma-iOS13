//
//  Album.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import Foundation

struct Album {
    var id: Int?
    var userId: Int?
    var title: String?
    let photos = [Photo]()
    
}

struct Photo {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
}
