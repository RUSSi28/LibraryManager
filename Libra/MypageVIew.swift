//
//  MypageVIew.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/16.
//

import SwiftUI

struct MypageVIew: View {
    @ObservedObject private var viewModel = BookViewModel()
    
    var body: some View {
        List {
            NavigationLink(destination: searchBookView()) {
                Text("本の追加")
            }
        }
    }
}

struct MypageVIew_Previews: PreviewProvider {
    static var previews: some View {
        MypageVIew()
    }
}
