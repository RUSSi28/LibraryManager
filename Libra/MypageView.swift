//
//  MypageVIew.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/16.
//

import SwiftUI

struct MypageView: View {
    @ObservedObject private var viewModel = BookViewModel()
    var user: String = "none"
    
    var body: some View {
        List {
            NavigationLink(destination: searchBookView()) {
                Text("本の追加")
            }
            NavigationLink(destination: BookListView(keyword: "", fetch: true, user: user, save: false, delete: true)) {
                Text("自分の本")
            }
        }
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}
