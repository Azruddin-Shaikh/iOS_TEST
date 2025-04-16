//
//  ViewController.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = ContentViewModel()
    private var showingStats = false
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray3
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        return pc
    }()
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search..."
        sb.delegate = self
        sb.searchTextField.clearButtonMode = .whileEditing
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.delegate = self
        tv.dataSource = self
        tv.register(ItemCell.self, forCellReuseIdentifier: ItemCell.identifier)
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var statsButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: "ellipsis.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.transform = CGAffineTransform(rotationAngle: .pi/2)
        button.addTarget(self, action: #selector(showStats), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    // MARK: - Setup
    
    /// Setup the UI components and layout
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(statsButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Carousel Collection View
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 180),
            
            // Page Control
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            
            // Search Bar
            searchBar.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Table View
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            
            // Stats Button
            statsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            statsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            statsButton.widthAnchor.constraint(equalToConstant: 45),
            statsButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    /// Setup view model and add observers
    private func setupViewModel() {
        viewModel.onDataLoaded = { [weak self] in
            guard let self = self else { return }
            self.pageControl.numberOfPages = self.viewModel.dataList.count
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
        
        viewModel.onDataFiltered = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.loadData()
    }
    
    // MARK: - Actions
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        viewModel.selectedCarouselIndex = sender.currentPage
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.searchText = ""
    }
    
    @objc private func showStats() {
        let statsVC = StatsViewController(listIndex: viewModel.selectedCarouselIndex, items: viewModel.filteredData)
        
        if let sheet = statsVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        present(statsVC, animated: true)
    }
}


// MARK: - UICollectionView Delegate & DataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as? CarouselCell else {
            return UICollectionViewCell()
        }
        
        // Let cell configure itself
        cell.configure(with: viewModel.dataList[indexPath.item].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = pageIndex
            viewModel.selectedCarouselIndex = pageIndex
            searchBar.text = ""
            searchBar.resignFirstResponder()
            viewModel.searchText = ""
        }
    }
}

// MARK: - UITableView Delegate & DataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        
        // Let cell configure itself
        let item = viewModel.filteredData[indexPath.row]
        cell.configure(with: viewModel.currentCarouselImage, item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - UISearchBar Delegate

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
