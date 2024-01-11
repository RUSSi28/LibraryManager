//
//  BookListView.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/22.
//

import SwiftUI

struct BookListView: View {
    @State var books: [BookInfo] = []
    
    var body: some View {
                
        VStack {
            List(books) {item in
                HStack {
                    AsyncImage(url: URL(string: item.thumbnailURL!)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 100, height: 100)
                    Text(item.title!)
                }
//                Text("\(books.count)")
            }
        }.onAppear {
            GoogleBooksAPI(keyword: "SwiftUI").getAPI { results in
                books = results
            }
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
