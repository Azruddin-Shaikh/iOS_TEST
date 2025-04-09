//
//  UICollectionView+Extension.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCollectionCell(vc: UIViewController, identifier: String) {
        self.delegate = vc as? UICollectionViewDelegate
        self.dataSource = vc as? UICollectionViewDataSource
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}
