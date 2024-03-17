//
//  WideScrollVIew.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/25.
//

import SwiftUI
import TagKit

struct MainScreenView: View {
    @State var inputText: String = ""
    let group1: String = "C0de"
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack{
                    BooksSectionView(heading: "\(group1)所有の書籍", group: group1)
                    BooksSectionView(heading: "個人所有の書籍")
                }
            }
        }
        .navigationTitle("BookSharing")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct BooksSectionView: View {
    let heading : String
    var group: String = ""
    
    var body: some View {
        VStack{
            Divider()
            Text(heading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            Divider()
            WideScrollView(group: group)
            Divider()
        }
    }
}


struct WideScrollView: View {
    @ObservedObject var viewModel = BookViewModel()
    var group: String = ""
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                HStack {
                    ForEach(viewModel.bookList) {book in
                        NavigationLink(destination: BookDetailView(book: book, save: false, delete: false)) {
                            BookWithTextView(book: book)
                            Divider()
                        }
                    }
                }
                NavigationLink(destination: BookListView(keyword: "", fetch: false, books: viewModel.bookList, save: false, delete: false)) {
                    Text("もっと見る")
                        .padding(.leading, 20)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }.onAppear {
            if group.isEmpty {
                viewModel.fetchBooks()
            } else {
                viewModel.fetchGroupsBook(group: group)
            }
        }
    }
}


struct BookWithTextView: View {
    let book: Book
    
    var body: some View {
        AsyncImage(url: URL(string: book.thumbnailURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.frame(width: 120, height: 160)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
//        WideScrollView(keywords: .constant("SwiftUI"))
//        BooksSectionView()
        MainScreenView()
    }
}
