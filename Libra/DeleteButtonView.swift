//
//  DeleteButtonView.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/03/14.
//

import SwiftUI
import FirebaseFirestore

struct DeleteButtonView: View {
    @ObservedObject var viewModel = BookViewModel()
    let document: String
    @State private var isShowingAlert = false
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.deleteElement(document: document) { error in
                    if let error = error {
                        print("Error: \(error)")
                    } else {
                        isShowingAlert.toggle()
                    }
                }
            }) {
                Text("削除")
            }.alert("", isPresented:  $isShowingAlert) {
                
            } message: {
                Text("削除しました")
            }
        }
    }
}

struct DeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButtonView(document: "none480071253X")
    }
}
