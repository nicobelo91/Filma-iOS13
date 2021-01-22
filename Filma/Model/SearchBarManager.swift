//
//  SearchBarManager.swift
//  Filma
//
//  Created by Nico Cobelo on 22/01/2021.
//

import Foundation

struct SearchBarManager {
    
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
}
