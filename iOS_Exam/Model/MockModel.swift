//
//  MockModel.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation

struct MockItem: Codable {
    let image: String
    let data: [MockItemData]
}

struct MockItemData: Codable {
    let title: String
    let subTitle: String
}
