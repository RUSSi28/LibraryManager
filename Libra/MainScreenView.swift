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
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack{
                    BooksSectionView(heading: "団体所有の書籍")
                    BooksSectionView(heading: "個人所有の書籍")
                }
            }
        }
        .navigationTitle("BookSharing")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct TagSectionView: View{
//    @State var tagList: [String] = []
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack{
//
//            }
//        }
//    }
//}

struct BooksSectionView: View {
    let heading :String
    @State var keyword: String = "Java"
    var body: some View {
        VStack{
            Divider()
            Text(heading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            Divider()
            WideScrollView()
            Divider()
        }
    }
}


struct WideScrollView: View {
    @ObservedObject var viewModel = BookViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                HStack {
                    ForEach(viewModel.bookList) {book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookWithTextView(book: book)
                            Divider()
                        }
                    }
                }
                NavigationLink(destination: BookListView(keyword: "", fetch: false,books: viewModel.bookList)) {
                    Text("もっと見る")
                        .padding(.leading, 20)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }.onAppear {
            viewModel.fetchBooks()
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
