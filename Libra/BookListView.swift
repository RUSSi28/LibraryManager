//
//  BookListView.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/22.
//

import SwiftUI

struct BookListView: View {
    @State var books: [BookInfo] = []
    @Binding var keyword: String
    
    var body: some View {
        NavigationView {
            List(books) {item in
                HStack {
                    NavigationLink(destination: BookDetailView(book: item)) {
                        AsyncImage(url: URL(string: item.thumbnailURL!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 100, height: 100)
                        Text(item.title!)
//                        Text(item.description!)
                    }
                }
            }
        }.onAppear {
            GoogleBooksAPI(keyword: keyword).getAPI { results in
                books = results
            }
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(keyword: .constant("SwiftUI"))
    }
}
