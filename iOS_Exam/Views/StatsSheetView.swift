//
//  StatsSheetView.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import SwiftUI

struct StatsSheetView: View {
    let listIndex: Int
    let items: [MockItemData]
    
    var body: some View {
        let topCharacters = getTopCharacters(from: items.map { $0.title })

        VStack(alignment: .leading, spacing: 16) {
            // Header
            Text("📊 Statistics")
                .font(.title2)
                .bold()
                .padding(.bottom, 4)
            
            // List info
            Text("List \(listIndex + 1) • \(items.count) items")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Top Characters Display
            VStack(spacing: 10) {
                ForEach(topCharacters, id: \.0) { char, count in
                    HStack {
                        Text("• \(char.uppercased())")
                            .font(.headline)
                            .frame(width: 40, alignment: .leading)
                            .foregroundColor(.blue)

                        Text("appears \(count) times")
                            .font(.body)
                            .foregroundColor(.primary)

                        Spacer()
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
    }

    /// Calculate the top 3 most frequent characters in the titles
    /// - Parameter titles: Array of title strings to analyze
    /// - Returns: Array of tuples containing character and count, sorted by frequency
    private func getTopCharacters(from titles: [String]) -> [(Character, Int)] {
        var freq: [Character: Int] = [:]
        for title in titles {
            for char in title.lowercased() where char.isLetter {
                freq[char, default: 0] += 1
            }
        }
        return Array(freq.sorted(by: { $0.value > $1.value }).prefix(3))
    }
}
