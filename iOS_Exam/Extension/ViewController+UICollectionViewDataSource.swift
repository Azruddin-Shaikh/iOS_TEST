//
//  ViewController+UICollectionViewDataSource.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as? CarouselCell {
            let imageName = dataList[indexPath.item].image
            cell.imgView.image = UIImage(named: imageName)
            return cell
        }
        return UICollectionViewCell()
    }
}
