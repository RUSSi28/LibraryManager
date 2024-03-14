//
//  User.swift
//  Libra
//
//  Created by 鶴見駿 on 2024/01/03.
//

import FirebaseFirestore
import FirebaseCore

struct Book: Identifiable {
    
    var isbooked: Bool = false
    var Owner: String
    var Borrower: String = ""
    
    // APIで取得
    var id: String
    var title: String
    var thumbnailURL: String
    var description: String
    var isbn13: String
    
    var tag1: String = ""
    var tag2: String = ""
    var tag3: String = ""
    var tag4: String = ""
    var tag5: String = ""
        
    init(isbooked: Bool,Owner: String, id: String, title: String, thumbnailURL: String, description: String, isbn13: String, tag1: String = "", tag2: String = "", tag3: String = "", tag4: String = "", tag5: String = "") {
        self.isbooked = isbooked
        self.Owner = Owner
        self.id = id
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.description = description
        self.isbn13 = isbn13
        
        self.tag1 = tag1
        self.tag2 = tag2
        self.tag3 = tag3
        self.tag4 = tag4
        self.tag5 = tag5
    }
}


extension Book {
    static let exampleBook: Book = Book(isbooked: false,
         Owner: "none",
         id: "uwMG1zg11LEC",
         title: "Javaセキュリティ",
         thumbnailURL: "http://books.google.com/books/content?id=uwMG1zg11LEC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", description: "本書は、Javaプログラムの観点から、セキュリティについて解説する。セキュリティを提供するJavaの基本的なプラットフォーム機能(クラスローダ、バイトコード検証器、セキュリティマネージャ)のほか、セキュリティモデルの強化のため、Javaに加えられた拡張(電子署名、セキュリティプロバイダ、アクセスコントローラ)を取り上げる。本書の目的は、Javaセキュリティモデルのアーキテクチャと、そのモデルをプログラム的に、またシステム管理的にどのように使用できるかについて理解してもらうことである。",
         isbn13: "9784873110646")
}

// データベースとやり取りするオブジェクト
class BookViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var bookList: [Book] = []
    
    // データの保存
    func saveBookData(book: Book, completion: @escaping (Error?) -> Void) {
        let documentName: String = book.Owner + book.isbn13
        let docRef = db.collection("C0de").document(documentName)
        
        docRef.setData([
            "isbooked": book.isbooked,
            "id": book.id,
            "title": book.title,
            "thumbnailURL": book.thumbnailURL,
            "description": book.description,
            "Owner": book.Owner,
            "Borrower": book.Borrower,
            "isbn13": book.isbn13,
            "tag1": book.tag1,
            "tag2": book.tag2,
            "tag3": book.tag3,
            "tag4": book.tag4,
            "tag5": book.tag5,
        ]) { error in
            completion(error)
        }
    }
    
    // 保存されたデータの削除
    func deleteElement(document: String, completion: @escaping (Error?) -> Void) {
        db.collection("C0de").document(document).delete() {error in
            completion(error)
        }
    }

    // データベースのC0deコレクションのドキュメントを全て取得
    func fetchBooks() {
        db.collection("C0de").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.bookList = snapshot?.documents.map {
                    Book(isbooked: $0.data()["isbooked"] as? Bool ?? false,
                         Owner: $0.data()["Owner"] as? String ?? "",
                         id: $0.data()["id"] as? String ?? "",
                         title: $0.data()["title"] as? String ?? "",
                         thumbnailURL: $0.data()["thumbnailURL"] as? String ?? "",
                         description: $0.data()["description"] as? String ?? "",
                         isbn13: $0.data()["isbn13"] as? String ?? "")
                } ?? []
            }
        }
    }
    
    // 特定のuser所有の本を取得
    func fetchMyBook(user: String) {
        db.collection("C0de").whereField("Owner", isEqualTo: user).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting owned documents: \(error)")
            } else {
                self.bookList = snapshot?.documents.map {
                    Book(isbooked: $0.data()["isbooked"] as? Bool ?? false,
                         Owner: $0.data()["Owner"] as? String ?? "",
                         id: $0.data()["id"] as? String ?? "",
                         title: $0.data()["title"] as? String ?? "",
                         thumbnailURL: $0.data()["thumbnailURL"] as? String ?? "",
                         description: $0.data()["description"] as? String ?? "",
                         isbn13: $0.data()["isbn13"] as? String ?? "")
                } ?? []
            }
        }
        
    }
    
    // APIで取得したBookInfoをBook型に変換
    func translateBookInfoToBook(booksInfo: [BookInfo]) {
        for bookInfo in booksInfo {
            self.bookList.append(Book(isbooked: false, Owner: "none", id: bookInfo.id!, title: bookInfo.title!, thumbnailURL: bookInfo.thumbnailURL!, description: bookInfo.description!, isbn13: bookInfo.isbn13!))
        }
    }
}
