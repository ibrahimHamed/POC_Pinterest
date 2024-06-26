//
//  SecondSolution.swift
//  POC-PinterestLayout
//
//  Created by Ibrahim Hamed on 26/06/2024.
//

import SwiftUI

struct SecondSolution: View {
    let gridItems = [
        GridItem(height: CGFloat.random(in: 60...1000),stringImage: "01"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "02"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "03"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "04"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "05"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "06"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "07"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "03"),
        GridItem(height: CGFloat.random(in: 60...300),stringImage: "05")
    ]
    
    
    var body: some View {
        ScrollView {
            PinterestGrid(gridItems: gridItems, numOfColumns: 2)
        }
    }
}

#Preview {
    SecondSolution()
}
