//
//  StatsViewController.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 16/04/25.
//

import UIKit


class StatsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let listIndex: Int
    private let items: [MockItemData]
    private let topCharacters: [(Character, Int)]
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "📊 Statistics"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - Initialization
    
    init(listIndex: Int, items: [MockItemData]) {
        self.listIndex = listIndex
        self.items = items
        self.topCharacters = StatsViewController.getTopCharacters(from: items.map { $0.title })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(statsStackView)
        
        // Configure info label
        infoLabel.text = "List \(listIndex + 1) • \(items.count) items"
        
        // Setup statistics views
        for (char, count) in topCharacters {
            let containerView = UIView()
            containerView.backgroundColor = .systemGray6
            containerView.layer.cornerRadius = 10
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let charLabel = UILabel()
            charLabel.text = "• \(String(char).uppercased())"
            charLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            charLabel.textColor = .systemBlue
            charLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let countLabel = UILabel()
            countLabel.text = "appears \(count) times"
            countLabel.font = UIFont.systemFont(ofSize: 14)
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(charLabel)
            containerView.addSubview(countLabel)
            
            NSLayoutConstraint.activate([
                containerView.heightAnchor.constraint(equalToConstant: 40),
                
                charLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                charLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                charLabel.widthAnchor.constraint(equalToConstant: 40),
                
                countLabel.leadingAnchor.constraint(equalTo: charLabel.trailingAnchor, constant: 8),
                countLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
            
            statsStackView.addArrangedSubview(containerView)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            statsStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Utility Methods
    
    /// Calculate the top 3 most frequent characters in the titles
    /// - Parameter titles: Array of title strings to analyze
    /// - Returns: Array of tuples containing character and count, sorted by frequency
    private static func getTopCharacters(from titles: [String]) -> [(Character, Int)] {
        var freq: [Character: Int] = [:]
        for title in titles {
            for char in title.lowercased() where char.isLetter {
                freq[char, default: 0] += 1
            }
        }
        return Array(freq.sorted(by: { $0.value > $1.value }).prefix(3))
    }
}
