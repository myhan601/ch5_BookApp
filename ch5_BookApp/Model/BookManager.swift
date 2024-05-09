//
//  BookManager.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/9/24.
//

import Foundation

class BookManager {
    static func fetchBooks(completion: @escaping ([Book]?) -> Void) {
        let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=세이노")!
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


