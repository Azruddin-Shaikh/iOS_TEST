//
//  ItemCell.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 16/04/25.
//

import SwiftUI

struct ItemCell: View {
    let image: String
    let item: MockItemData
    
    var body: some View {
        HStack(spacing: 10) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                Text(item.subTitle)
            }
        }
        .padding(5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}
