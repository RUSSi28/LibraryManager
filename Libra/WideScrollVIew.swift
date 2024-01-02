//
//  WideScrollVIew.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/25.
//

import SwiftUI

struct MainScreenView: View {
    @State var inputText: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                ScrollView(.vertical) {
                    VStack{
                        BooksSectionView(heading: "団体所有の書籍")
                        BooksSectionView(heading: "個人所有の書籍")
                    }
                }
            }.navigationTitle("BookSharing").navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TagSectionView: View{
    @State var tagList: [String] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                
            }
        }
    }
}

struct BooksSectionView: View {
    let heading :String
    var body: some View {
        VStack{
            Divider()
            Text(heading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            Divider()
            WideScrollView(keywords: .constant("SwiftUI"))
            Divider()
            NavigationLink(destination: BookListView()) {
                Text("もっと見る")
                    .padding(.leading, 20)
            }
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
        }
        
    }
}


struct WideScrollView: View {
    @State var books:[Book] = []
    @Binding var keywords: String
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(books) {item in
                    NavigationLink(destination: BookDetailView(book: item)) {
                        BookWithTextView(book: item)
                    }
                }
            }
        }.onAppear {
            GoogleBooksAPI(keyword: "SwiftUI").getAPI { result in
                books = result
            }
        }
    }
}


struct BookWithTextView: View {
    let book: Book
    
    var body: some View {
        AsyncImage(url: URL(string: book.thumbnailURL!)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.frame(width: 120, height: 160)
    }
}

struct WideScrollView_Previews: PreviewProvider {
    static var previews: some View {
//        WideScrollView(keywords: .constant("SwiftUI"))
//        BooksSectionView()
        MainScreenView()
    }
}
