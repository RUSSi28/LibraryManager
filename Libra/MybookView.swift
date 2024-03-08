//
//  MybookVIew.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/02/29.
//

import SwiftUI

struct MybookView: View {
    @ObservedObject var viewModel = BookViewModel()
    
    var body: some View {
        VStack {
            BookListView(keyword: "", fetch: false, books: viewModel.bookList)
        }.onAppear {
            viewModel.fetchBooks()
        }
    }
}

struct MybookView_Previews: PreviewProvider {
    static var previews: some View {
        MybookView()
    }
}
