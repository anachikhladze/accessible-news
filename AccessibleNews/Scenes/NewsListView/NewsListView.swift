//
//  ContentView.swift
//  AccessibleNews
//
//  Created by Anna Sumire on 27.12.23.
//

import SwiftUI

struct NewsListView: UIViewRepresentable {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    @ObservedObject var viewModel: NewsViewModel
    @State private var rows: [String] = []
    
    // MARK: - UIViewRepresentable methods
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newsCell")
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        DispatchQueue.main.async {
            rows = viewModel.newsTitles
            uiView.reloadData()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(rows: $rows, dynamicTypeSize: dynamicTypeSize)
    }
    
    // MARK: - Coordinator class
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        @Binding var rows: [String]
        
        var dynamicTypeSize: DynamicTypeSize
        
        init(rows: Binding<[String]>, dynamicTypeSize: DynamicTypeSize) {
            _rows = rows
            self.dynamicTypeSize = dynamicTypeSize
        }
        
        // MARK: - UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            rows.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
            configureCell(cell: cell, at: indexPath)
            return cell
        }
        
        // MARK: - UITableViewDelegate
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            100
        }
        
        // MARK: - Cell configuration
        func configureCell(cell: UITableViewCell, at indexPath: IndexPath) {
            let view = Text(rows[indexPath.row])
                .frame(height: 50)
                .minimumScaleFactor(dynamicTypeSize == DynamicTypeSize.xxLarge ? 0.8 : 0.5)
            // VoiceOver
                .accessibility(label: Text(rows[indexPath.row]))
            
            let controller = UIHostingController(rootView: view)
            let contentView = controller.view!
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(contentView)
            contentView.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            contentView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor).isActive = true
        }
    }
}

// MARK: - Preview
#Preview {
    NewsListView(viewModel: NewsViewModel())
}
