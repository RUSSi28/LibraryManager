//
//  User.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/03.
//

import FirebaseFirestore

struct TextBook: Identifiable {
    var id: String
    var isbooked: Bool
    var Owner: String
    var borrower: String
    var isbn: String
    var tag1: String = ""
    var tag2: String = ""
    var tag3: String = ""
    var tag4: String = ""
    var tag5: String = ""
}

class TextBookViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var textList: [TextBook] = []
    
//    func saveTextBook()
}
