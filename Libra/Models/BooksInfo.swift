//
//  BooksInfo.swift
//  Libra
//
//  Created by 鶴見駿 on 2023/12/23.
//

import UIKit
import SwiftyJSON
import Alamofire

class Book: Identifiable {
    var id: String?
    var title: String?
    var thumbnailURL: String?
}

class GoogleBooksAPI {
    var keyword: String
    
    public func getAPI(completion: @escaping ([Book]) -> Void) {
        AF.request("https://www.googleapis.com/books/v1/volumes?q=\(keyword)&maxResults=20").response { response in
            do {
                var json = try? JSON(data: response.data!)
                completion(self.setVolume(json!))
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setVolume(_ json: JSON) -> [Book] {
        let items = json["items"].array!
        var books: [Book] = []
        for item in items {
            let bk = Book()
            bk.id = item["id"].stringValue
            bk.title = item["volumeInfo"]["title"].stringValue
            bk.thumbnailURL = item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
            books.append(bk)
        }
        return books
    }
    
    init(keyword: String) {
        self.keyword = keyword
    }
}
