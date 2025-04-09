//
//  ViewController+UITableView.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation
import UIKit

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell {
            let item = filteredData[indexPath.row]
            let image = dataList[pageControl.currentPage].image
            cell.imgView.image = UIImage(named: image)
            cell.titleLabel.text = item.title
            cell.subTitleLabel.text = item.subTitle
            return cell
        }
        return UITableViewCell()
    }
}
