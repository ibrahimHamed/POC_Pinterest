//
//  PinterestGrid.swift
//  POC-PinterestLayout
//
//  Created by Ibrahim Hamed on 26/06/2024.
//

import SwiftUI

struct GridItem: Identifiable {
    let id = UUID()
    let height: CGFloat
    let stringImage: String
}

struct PinterestGrid: View {
    struct Column: Identifiable {
        let id = UUID()
        var gridItems = [GridItem]()
    }
    
    var columns = [Column]()
    
    init(gridItems: [GridItem], numOfColumns: Int, spacing: CGFloat = 20) {
        self.spacing = spacing
        var columns: [Column] = []
        
        for _ in 0..<numOfColumns {
            columns.append(Column())
        }
        
        var columnsHeight = Array<CGFloat>(repeating: 0, count: numOfColumns)
        
        for gridItem in gridItems {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!
            for i in 1..<columnsHeight.count {
                let currentHeight = columnsHeight[i]
                if currentHeight < smallestHeight {
                    smallestColumnIndex = i
                    smallestHeight = currentHeight
                }
            }
            columns[smallestColumnIndex].gridItems.append(gridItem)
            columnsHeight[smallestColumnIndex] += gridItem.height
        }
        
        self.columns = columns
    }
    
    
    
    
    var spacing: CGFloat = 10
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing){
            ForEach(columns) { columns in
                LazyVStack(spacing: spacing) {
                    ForEach(columns.gridItems.indices, id: \.self) { index in
                        getItemView(gridItem: columns.gridItems[index])
                            .overlay(
                                Color.orange
                                    .frame(width: 24, height: 24)
                                    .overlay {
                                        Text("\(index)")
                                            .font(.system(size: 20,weight: .bold))
                                            .foregroundStyle(.black)
                                    }
                            )
                    }
                }
            }
        }
        .padding(10)
    }
    
    func getItemView(gridItem: GridItem) -> some View {
        ZStack {
            GeometryReader { geometry in
                Image(gridItem.stringImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: gridItem.height)
        //        .background(HeightPreferenceSetter())
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
