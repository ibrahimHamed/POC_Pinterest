/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct MasonryLayout<Content>: View
where Content : View
{
    var axis: Axis
    var content: (() -> Content)?
    var horizontalSpacing: CGFloat
    var lines: Int
    var size: CGSize
    var verticalSpacing: CGFloat
    
    var body: some View {
        var alignments = Array(repeating: CGFloat.zero, count: lineCount)
        var currentIndex = defaultIndex
        var currentLineSpan = 1
        var top: CGFloat = 0
        
        ZStack(alignment: .topLeading) {
            Group {
                if let content = content {
                    content()
                        .frame(width: axis == .vertical ? lineSize : nil, height: axis == .horizontal ? lineSize : nil)
                }
            }
            .fixedSize(horizontal: axis == .horizontal, vertical: axis == .vertical)
            .alignmentGuide(.leading) { dimensions in
                func updateCurrentLineSpan() {
                    switch axis {
                    case .horizontal:
                        currentLineSpan = Int(round((dimensions.height + verticalSpacing) / (lineSize + verticalSpacing)))
                    case .vertical:
                        currentLineSpan = Int(round((dimensions.width + horizontalSpacing) / (lineSize + horizontalSpacing)))
                    }
                }
                
                updateCurrentLineSpan()
                
                currentIndex = alignments
                    .enumerated()
                    .map { enumerated -> (element: CGFloat, offset: Int) in
                        let element = (0..<currentLineSpan).reduce(enumerated.element) { alignment, span in
                            guard alignments.indices.contains(enumerated.offset + span)
                            else { return -.infinity }
                            return min(alignment, alignments[enumerated.offset + span])
                        }
                        return (element, enumerated.offset)
                    }
                    .sorted { $0.element > $1.element }
                    .first!
                    .offset
                
                switch axis {
                case .horizontal:
                    let leading = alignments[currentIndex..<min(currentIndex + currentLineSpan, lineCount)].min()!
                    top = CGFloat(-currentIndex) * (lineSize + verticalSpacing)
                    for index in currentIndex..<min(currentIndex + currentLineSpan, lineCount) {
                        alignments[index] = leading - dimensions.width - horizontalSpacing
                    }
                    return leading
                    
                case .vertical:
                    top = alignments[currentIndex..<min(currentIndex + currentLineSpan, lineCount)].min()!
                    for index in currentIndex..<min(currentIndex + currentLineSpan, lineCount) {
                        alignments[index] = top - dimensions.height - verticalSpacing
                    }
                    return CGFloat(-currentIndex) * (lineSize + horizontalSpacing)
                }
            }
            .alignmentGuide(.top) { _ in
                top
            }
            
            Color.clear
                .frame(width: 1, height: 1)
                .hidden()
                .alignmentGuide(.leading) { _ in
                    alignments = Array(repeating: .zero, count: lineCount)
                    currentIndex = defaultIndex
                    currentLineSpan = 1
                    top = 0
                    return 0
                }
        }
    }
    
    private var defaultIndex: Int {
        return 0
    }
    private var lineCount: Int {
        let currentSize: CGFloat
        let currentSpacing: CGFloat
        
        switch axis {
        case .horizontal:
            currentSize = size.height
            currentSpacing = verticalSpacing
        case .vertical:
            currentSize = size.width
            currentSpacing = horizontalSpacing
        }
        
        var count: Int
        let minCount = 1
        let maxCount = max(Int(ceil((currentSize + currentSpacing) / (1 + currentSpacing))), 1)
        
        count = lines
        
        return min(max(count, minCount), maxCount)
    }
    private var lineSize: CGFloat {
        let currentSize: CGFloat
        let currentSpacing: CGFloat
        
        switch axis {
        case .horizontal:
            currentSize = size.height
            currentSpacing = verticalSpacing
        case .vertical:
            currentSize = size.width
            currentSpacing = horizontalSpacing
        }
        
        return max((currentSize - (currentSpacing * CGFloat(lineCount - 1))) / CGFloat(lineCount), 0)
    }
}
