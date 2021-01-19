//
//  Album.swift
//  Filma
//
//  Created by Nico Cobelo on 19/01/2021.
//

import Foundation

struct Album: Decodable, Identifiable {
    var id: Int
    var userId: Int
    var title: String
}
