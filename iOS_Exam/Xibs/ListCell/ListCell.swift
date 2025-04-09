//
//  ListCell.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import UIKit

class ListCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!

    //MARK: - Override Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.layer.cornerRadius = 8
        self.mainView.layer.cornerRadius = 8
        self.mainView.layer.borderWidth = 1
        self.mainView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
