//
//  CarouselView.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import SwiftUI

struct CarouselView: View {
    @Binding var selectedIndex: Int
    let data: [MockItem]

    var body: some View {
        VStack {
            // TabView for paging through images
            TabView(selection: $selectedIndex) {
                ForEach(0..<data.count, id: \.self) { index in
                    Image(data[index].image)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 180)
            
            // Custom indicator dots
            HStack(spacing: 8) {
                ForEach(0..<data.count, id: \.self) { index in
                    Circle()
                        .fill(index == selectedIndex ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}
