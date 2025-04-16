//
//  ContentViewModel.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published private(set) var dataList: [MockItem] = []
    @Published var searchText = ""
    @Published var selectedCarouselIndex: Int = 0
    
    /// Returns the current carousel image based on selected index
    var currentCarouselImage: String {
        dataList[selectedCarouselIndex].image
    }
    
    /// Returns item data for the currently selected carousel index
    var currentItemData: [MockItemData] {
        dataList[selectedCarouselIndex].data
    }
    
    /// Returns filtered data based on search text
    var filteredData: [MockItemData] {
        if searchText.isEmpty {
            return dataList[selectedCarouselIndex].data
        } else {
            return dataList[selectedCarouselIndex].data.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    /// Initializes the view model and loads mock data
    init() {
        loadData()
    }
    
    /// Loads mock data from the service
    private func loadData() {
        if let mockData = MockService.shared.loadMockJson() {
            self.dataList = mockData
        } else {
            self.dataList = []
        }
    }
}
