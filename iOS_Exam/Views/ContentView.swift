//
//  ContentView.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import SwiftUI

struct ContentView: View {
    // Use private access modifiers as suggested in feedback
    @StateObject private var viewModel = ContentViewModel()
    @State private var showSheet = false
    // UIApplication environment to dismiss keyboard
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    
                    // Carousel view displaying images
                    CarouselView(
                        selectedIndex: $viewModel.selectedCarouselIndex,
                        data: viewModel.dataList
                    )
                    .padding(.bottom, 16)
                    
                    Section(header: searchBar) {
                        let items = viewModel.filteredData
                        ForEach(
                            0..<items.count,
                            id: \.self
                        ) { index in
                            let item = items[index]
                            ItemCell(image: viewModel.currentCarouselImage, item: item)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 70)
            }
            .clipped()
            
            // Action button for statistics sheet
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "ellipsis.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(90))
            }
            .padding()
        }
        .onChange(of: viewModel.selectedCarouselIndex) { _ in
            // Clear search text and dismiss keyboard when category changes
            viewModel.searchText = ""
            hideKeyboard()
        }
        .sheet(isPresented: $showSheet) {
            // Pass filtered data to reflect correct statistics based on search results
            StatsSheetView(
                listIndex: viewModel.selectedCarouselIndex,
                items: viewModel.filteredData
            )
            .presentationDetents([.height(230)])
        }
    }
    
    /// Search bar with clear button functionality
    private var searchBar: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 10)
            
            TextField("Search...", text: $viewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
            
            // Clear button that appears when search text is not empty
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            Color(.systemGray4)
                .cornerRadius(5)
        )
        .padding([.horizontal, .bottom])
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    /// Dismisses the keyboard
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
