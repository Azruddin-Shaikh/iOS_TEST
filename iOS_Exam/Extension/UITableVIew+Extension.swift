//
//  UITableVIew+Extension.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation
import UIKit

extension UITableView {
    func registerTableCell(vc: UIViewController, identifier: String) {
        self.delegate = vc as? UITableViewDelegate
        self.dataSource = vc as? UITableViewDataSource
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
