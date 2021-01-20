//
//  PhotoDetailVC.swift
//  Filma
//
//  Created by Nico Cobelo on 20/01/2021.
//

import UIKit

class PhotoDetailVC: UIViewController {

    
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var photoTitle: UILabel!
    @IBOutlet var photoId: UILabel!
    @IBOutlet var photoAlbumId: UILabel!
    
    var selectedPhoto: Photo!
    var filmaManager = FilmaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImage.image = filmaManager.urlToImg(selectedPhoto.url!)
        photoTitle.text = selectedPhoto.title
        photoId.text = "Photo ID: \(selectedPhoto.id ?? 0)"
        photoAlbumId.text = "Album ID: \(selectedPhoto.albumId ?? 0)"
        
    }

}
