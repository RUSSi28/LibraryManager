//
//  BookListView.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/22.
//

import SwiftUI

struct BookListView: View {
    @State var books: [Book] = []
    
    var body: some View {
                
        VStack {
            List(books) {item in
                NavigationLink(destination: BookDetailView(book: item)) {
                    BookInformation(book: item)
                }
            }
        }.onAppear {
            GoogleBooksAPI(keyword: "SwiftUI").getAPI { results in
                books = results
            }
        }
    }
}

struct BookInformation: View {
    let book : Book
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: book.thumbnailURL!)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 80, height: 100)
            Text(book.title!)
        }
    }
}


struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
