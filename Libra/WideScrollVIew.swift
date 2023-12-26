//
//  WideScrollVIew.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/25.
//

import SwiftUI

struct WideScrollView: View {
    @State var books:[Book] = []
    @Binding var keywords: String
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(books) {item in
                    AsyncImage(url: URL(string: item.thumbnailURL!)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 100, height: 100)
                }
            }
        }.onAppear {
            GoogleBooksAPI(keyword: "SwiftUI").getAPI { result in
                books = result
            }
        }
    }
}

struct WideScrollView_Previews: PreviewProvider {
    static var previews: some View {
        WideScrollView(keywords: .constant("SwiftUI"))
    }
}
