//
//  ContentView.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    let list = ["apple", "banana", "orange", "blueberry"]
        @State private var showSheet = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    
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
                            HStack (spacing: 10){
                                Image(viewModel.currentCarouselImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading, spacing: 5){
                                    Text(item.title)
                                    Text(item.subTitle)
                                }
                            }
                            .padding(5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 70)
            }
            .clipped()
            
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
        .onChange(of: viewModel.selectedCarouselIndex) {
            viewModel.searchText = ""
        }
        .sheet(isPresented: $showSheet) {
            StatsSheetView(
                listIndex: viewModel.selectedCarouselIndex,
                items: viewModel.currentItemData
            )
            .presentationDetents([.height(230)])
        }
    }
    
    var searchBar: some View {
        HStack (spacing: 0){
            Image(systemName: "magnifyingglass")
                .padding(.leading, 10)
            TextField("Search...", text: $viewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(
            Color(.systemGray4)
                .cornerRadius(5)
        )
        .padding([.horizontal, .bottom])
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ContentView()
}
