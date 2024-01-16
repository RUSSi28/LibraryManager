//
//  User.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/03.
//

import FirebaseFirestore

struct Book {
//    GoogleBooksAPIのメンバ
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

class BookViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var textList: [Book] = []
    
    func saveBookData(book: Book, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("C0de").document()
        
        docRef.setData([
            "isbooked": book.isbooked,
            "id": book.bookInfo?.id,
            "title": book.bookInfo?.title,
            "thumnailURL": book.bookInfo?.thumbnailURL,
            "description": book.bookInfo?.description,
            "Owner": book.Owner,
            "Borrower": book.Borrower,
            "tag1": book.tag1,
            "tag2": book.tag2,
            "tag3": book.tag3,
            "tag4": book.tag4,
            "tag5": book.tag5
        ]) { error in
            completion(error)
        }
    }
    
    func showBooksEveryTag(Tag: String) {
        
    }
}
