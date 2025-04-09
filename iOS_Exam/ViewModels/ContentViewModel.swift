//
//  ContentViewModel.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation


class ContentViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCarouselIndex: Int = 0
    @Published var dataList: [MockItem] = []
    
    var currentCarouselImage: String {
        dataList[selectedCarouselIndex].image
    }
    var currentItemData: [MockItemData] {
        dataList[selectedCarouselIndex].data
    }
    
    var filteredData: [MockItemData] {
        if searchText.isEmpty {
            return dataList[selectedCarouselIndex].data
        } else {
            return dataList[selectedCarouselIndex].data.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init() {
        dataList = MockService.shared.loadMockJson() ?? []
    }
}
