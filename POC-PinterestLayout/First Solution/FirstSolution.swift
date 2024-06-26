//
//  FirstSolution.swift
//  POC-PinterestLayout
//
//  Created by Ibrahim Hamed on 26/06/2024.
//

import SwiftUI

struct FirstSolution: View {
    @State private var images: [String] = ["01","02","03","04","05","06","07","03","05"]
    
    var body: some View {
        ScrollView {
            VStack {
                Masonry(.vertical, lines: 2) {
                    
                    ForEach(0..<images.count, id: \.self) { index in
                        ZStack {
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.green)
                                .cornerRadius(16)
                            Rectangle()
                                .foregroundStyle(.white)
                                .cornerRadius(8)
                                .frame(width: 30, height: 30)
                            Text("\(index + 1)")
                                .font(.system(size: 24))
                                .bold()
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    FirstSolution()
}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
