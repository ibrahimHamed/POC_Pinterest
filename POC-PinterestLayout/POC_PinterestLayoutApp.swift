//
//  POC_PinterestLayoutApp.swift
//  POC-PinterestLayout
//
//  Created by Ibrahim Hamed on 26/06/2024.
//

import SwiftUI

@main
struct POC_PinterestLayoutApp: App {
    @State var isFirst: Bool = true
    var body: some Scene {
        WindowGroup {
            Picker("Select", selection: $isFirst) {
                Text("FirstSolution").tag(true)
                Text("SecondSolution").tag(false)
            }
            .pickerStyle(.segmented)
            Group {
                if isFirst {
                    FirstSolution()
                } else {
                    SecondSolution()
                }
            }
        }
    }
}
