//
//  ViewController+UISearchBar.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation
import UIKit

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            filteredData =  currentItemData
        } else {
            filteredData = currentItemData.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        dataTableView.reloadData()
    }
}
