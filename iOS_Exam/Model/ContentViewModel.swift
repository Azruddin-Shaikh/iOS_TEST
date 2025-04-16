//
//  ContentViewModel.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 16/04/25.
//


class ContentViewModel {
    
    // MARK: - Properties
    
    private(set) var dataList: [MockItem] = []
    private var _selectedCarouselIndex: Int = 0
    var selectedCarouselIndex: Int {
        get { return _selectedCarouselIndex }
        set {
            _selectedCarouselIndex = newValue
            searchText = ""
            filterData()
        }
    }
    
    var searchText: String = "" {
        didSet {
            filterData()
        }
    }
    
    private(set) var filteredData: [MockItemData] = []
    
    // MARK: - Computed Properties
    
    var currentCarouselImage: String {
        guard !dataList.isEmpty else { return "" }
        return dataList[_selectedCarouselIndex].image
    }
    
    var currentItemData: [MockItemData] {
        guard !dataList.isEmpty else { return [] }
        return dataList[_selectedCarouselIndex].data
    }
    
    // MARK: - Callbacks
    
    var onDataLoaded: (() -> Void)?
    var onDataFiltered: (() -> Void)?
    
    // MARK: - Public Methods
    
    /// Loads mock data from the service
    func loadData() {
        if let mockData = MockService.shared.loadMockJson() {
            self.dataList = mockData
            filterData()
            onDataLoaded?()
        }
    }
    
    // MARK: - Private Methods
    
    /// Filters data based on search text
    private func filterData() {
        guard !dataList.isEmpty else {
            filteredData = []
            return
        }
        
        if searchText.isEmpty {
            filteredData = dataList[_selectedCarouselIndex].data
        } else {
            filteredData = dataList[_selectedCarouselIndex].data.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        onDataFiltered?()
    }
}
