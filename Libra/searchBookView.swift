//
//  searchBookView.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/13.
//

import SwiftUI

struct searchBookView: View {
    @State var keyword: String = ""
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            TextField("title or keyword", text: $keyword).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            
            NavigationLink(destination: BookListView(keyword: keyword, fetch: false, save: true, delete: false)) {
                Text("Search")
            }
        }
    }
}

struct searchBookView_Previews: PreviewProvider {
    static var previews: some View {
        searchBookView()
    }
}
