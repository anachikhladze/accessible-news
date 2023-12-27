//
//  AccessibleNewsApp.swift
//  AccessibleNews
//
//  Created by Anna Sumire on 27.12.23.
//

import SwiftUI

@main
struct AccessibleNewsApp: App {
    var body: some Scene {
        WindowGroup {
            NewsListView(viewModel: NewsViewModel())
        }
    }
}
