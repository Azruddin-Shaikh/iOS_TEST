//
//  CarouselCell.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK: - Override Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.layer.cornerRadius = 12.0
    }

}
