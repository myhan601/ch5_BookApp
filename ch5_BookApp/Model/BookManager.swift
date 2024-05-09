//
//  BookManager.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/9/24.
//

import Foundation

class BookManager {
    static let shared = BookManager()
    
    // query 매개변수를 추가합니다.
    static func fetchBooks(query: String, completion: @escaping ([Book]?) -> Void) {
        // URL 문자열 내의 query 부분을 매개변수로 받은 query로 대체합니다.
        // URL 인코딩을 해주어야 합니다. query에 공백이나 특수문자가 포함될 수 있기 때문입니다.
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(encodedQuery)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "KakaoAK 69e56acfc0c35b5b4430df229d2d5c6b"]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(BookSearchResponse.self, from: data)
                completion(decodedData.documents)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
