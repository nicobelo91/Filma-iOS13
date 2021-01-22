//
//  PhotoDetailVC.swift
//  Filma
//
//  Created by Nico Cobelo on 20/01/2021.
//

import UIKit
import ChameleonFramework

class PhotoDetailVC: UIViewController {

    
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var photoTitle: UILabel!
    @IBOutlet var photoId: UILabel!
    @IBOutlet var photoAlbumId: UILabel!
    
    var selectedPhoto: Photo!
    var filmaManager = FilmaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImage.sd_setImage(with: URL(string: selectedPhoto.url!))
        photoTitle.text = selectedPhoto.title
        photoId.text = "Photo ID: \(selectedPhoto.id ?? 0)"
        photoAlbumId.text = "Album ID: \(selectedPhoto.albumId ?? 0)"
        
//        if let color = HexColor(selectedPhoto.color!) {
//            view.backgroundColor = color
//            photoTitle.textColor = ContrastColorOf(color, returnFlat: true)
//            photoId.textColor = ContrastColorOf(color, returnFlat: true)
//            photoAlbumId.textColor = ContrastColorOf(color, returnFlat: true)
//        
//        }
        
    }

    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        guard let image = photoImage.image?.jpegData(compressionQuality: 0.8) else {
                print("No image found")
                return
            }
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
    }
}
