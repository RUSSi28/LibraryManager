//
//  BookDetailView.swift
//  Libra
//
//  Created by orukunnn on 2023/12/30.
//

import SwiftUI

struct BookDetailView: View {
    let book: BookInfo
    
    var body: some View {
        ScrollView(.vertical){
            VStack(){
                TitleWithBookImageView(book: book)
                
                Spacer(minLength: 16)
                Divider()
                
                FoldableDescriptionView(bookDescription: book.description!)
            }.padding(20)
        }
    }
}

struct TitleWithBookImageView: View {
    let book: BookInfo
    
    var body: some View {
        VStack{
            Text(book.title!)
                .bold()
                .font(.largeTitle)
            AsyncImage(url: URL(string: book.thumbnailURL!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 240, height: 320)
        }
    }
}

struct FoldableDescriptionView: View {
    let bookDescription: String
    @State var isFold = true
    @State var needFoldButton = true
    @State var textHeight: CGFloat? = 80
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack{
                Text("説明：\n" + bookDescription)
                    .onPreferenceChange(SizePreference.self) { textSize in
                        if textSize.height > 80 {
                            self.textHeight = 80
                            self.isFold = true
                        } else {
                            self.needFoldButton = false
                        }
                    }
                    .frame(height: textHeight)
                Spacer()
            }
            
            if needFoldButton {
                Button(action: {
                    self.isFold.toggle()
                    if self.isFold {
                        self.textHeight = 80
                    } else {
                        self.textHeight = nil
                    }
                }) {
                    Text(isFold ? "続きを読む" : "閉じる")
                }.padding(.trailing, 8)
            }
        }
    }
}



fileprivate struct SizePreference: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: BookInfo())
    }
}
