//
//  ViewController.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var carouselCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var dataTableView: UITableView!
    
    // MARK: - Properties
    var dataList: [MockItem] = []
    var currentItemData: [MockItemData] = []
    var filteredData: [MockItemData] = []
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerCell()
        self.getData()
    }
    
    private func registerCell() {
        self.searchBar.delegate = self
        self.carouselCollectionView.registerCollectionCell(vc: self, identifier: CarouselCell.identifier)
        self.dataTableView.registerTableCell(vc: self, identifier: ListCell.identifier)
    }
    
    private func getData() {
        guard let items = MockService.shared.loadMockJson() else { return }
        self.dataList = items
        self.pageControl.numberOfPages = self.dataList.count
        self.currentItemData = items[pageControl.currentPage].data
        self.filteredData = items[pageControl.currentPage].data
        
        self.carouselCollectionView.reloadData()
        self.dataTableView.reloadData()
    }
}
