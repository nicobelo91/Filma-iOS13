//
//  SearchBarManager.swift
//  Filma
//
//  Created by Nico Cobelo on 22/01/2021.
//

import UIKit

class SearchBarManager: UIViewController {
    
    func changeNumOfColumns(_ selectedScope: Int) -> ColumnFlowLayout {
        
        var columnLayout: ColumnFlowLayout
        switch selectedScope {
        case 0:
            columnLayout = ColumnFlowLayout(cellsPerRow: 1, minimumInteritemSpacing: 0, minimumLineSpacing: 0)
        case 1:
            columnLayout = ColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 0, minimumLineSpacing: 0)
        default:
            columnLayout = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 0, minimumLineSpacing: 0)
        }
        return columnLayout
    }
    

    func configureAlbumSearchController(_ searchController: UISearchController, _ navigationItem: UINavigationItem) {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Albums"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func configurePhotoSearchController(_ searchController: UISearchController, _ navigationItem: UINavigationItem) {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photos"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["1 Column", "2 Columns", "3 Columns"]
        searchController.searchBar.selectedScopeButtonIndex = 2

    }
}
