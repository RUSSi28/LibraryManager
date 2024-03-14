//
//  MybookVIew.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/02/29.
//

import SwiftUI

struct MybookView: View {
    @ObservedObject var viewModel = BookViewModel()
    let user: String = "none"
    
    var body: some View {
            BookListView(keyword: "", fetch: false, user: user, save: false, delete: true)
    }
}

struct MybookView_Previews: PreviewProvider {
    static var previews: some View {
        MybookView()
    }
}
