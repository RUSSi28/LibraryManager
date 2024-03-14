//
//  HomeView.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/02/24.
//

import SwiftUI

struct HomeView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            MainScreenView().tag(1)
            searchBookView().tag(2)
            MypageView().tag(3)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
