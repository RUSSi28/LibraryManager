//
//  addBookListView.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/03.
//

// 動作テスト

import SwiftUI
import FirebaseFirestore

struct addBookListView: View {
    @State var title: String = ""
    @ObservedObject private var viewModel = BookViewModel()
    
    @State var keyword: String = ""
    
    var body: some View {
        VStack {
            TextField("Title", text: $title) {
                
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            Button("Save") {
                
            }
        }
    }
}

struct addBookListView_Previews: PreviewProvider {
    static var previews: some View {
        addBookListView()
    }
}
