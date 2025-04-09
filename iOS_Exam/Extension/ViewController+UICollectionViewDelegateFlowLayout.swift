//
//  ViewController+UICollectionViewDelegateFlowLayout.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in carouselCollectionView.visibleCells {
            if let indexPath = carouselCollectionView.indexPath(for: cell) {
                guard indexPath.item < dataList.count else { return }
                self.currentItemData = dataList[indexPath.item].data
                self.filteredData = dataList[indexPath.item].data
                self.pageControl.currentPage = indexPath.item
                self.searchBar.text = ""
                self.dataTableView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 16), height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
