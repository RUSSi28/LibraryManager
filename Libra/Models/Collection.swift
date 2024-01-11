//
//  User.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/03.
//

import FirebaseFirestore

struct Book: Identifiable {
//    GoogleBooksAPIのメンバ
    let id = UUID()
//    let title: String
//    let thumbnailURL: String
    
    var bookInfo: BookInfo?
    
    var isbooked: Bool = false
    var Owner: String
    var Borrower: String = ""
//    var isbn: String
    var tag1: String = ""
    var tag2: String = ""
    var tag3: String = ""
    var tag4: String = ""
    var tag5: String = ""
        
    init(Owner: String, bookInfo: BookInfo) {
        self.Owner = Owner
        self.bookInfo = bookInfo
    }
}

class TextBookViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var textList: [Book] = []
    
    func saveBookData(textBook: Book, Owner: String ,completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("C0de").document()
        
        docRef.setData([
            "isbooked": textBook.isbooked,
            "Owner": textBook.Owner,
            "Borrower": textBook.Borrower,
            "tag1": textBook.tag1,
            "tag2": textBook.tag2,
            "tag3": textBook.tag3,
            "tag4": textBook.tag4,
            "tag5": textBook.tag5
        ]) { error in
            completion(error)
        }
    }
    
//    func borrowTextBook(Owner: String, Borrower: String, Group: String) {
//        let docRef = db.collection(Group).document()
//
//        let textBook = TextBook(isbooked: true, Owner: Owner, Borrower: Borrower, bookInfo: BookInfo?)
//    }
    
    func showBooksEveryTag(Tag: String) {
        
    }
}
