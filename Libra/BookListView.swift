//
//  BookListView.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/22.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var viewModel = BookViewModel()
    var keyword: String
    
    var fetch: Bool
    var books: [Book] = []
    
    var body: some View {
        VStack {
            Text("\(books.count)")
            Text("\(viewModel.bookList.count)")
            List(viewModel.bookList) {book in
                VStack {
                    HStack {
                        NavigationLink(destination: BookDetailView(book: book)) {
                            AsyncImage(url: URL(string: book.thumbnailURL)){ image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 100, height: 100)
                            
                            Text(book.title)
                        }
                    }
                }
            }
        }
        .onAppear {
            if !keyword.isEmpty {
                GoogleBooksAPI(keyword: keyword).getAPI { results in
                    viewModel.translateBookInfoToBook(booksInfo: results)
                }
            } else if fetch == true {
                viewModel.fetchBooks()
            } else if !books.isEmpty {
                viewModel.makeBookList(books: books)
            }
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
//        BookListView(keyword: "Java", fetch: false)
        BookListView(keyword: "", fetch: false, books: [Book.exampleBook, Book.exampleBook])
    }
}
