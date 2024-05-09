//
//  BookManager.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/9/24.
//

import Foundation

// URLSession을 사용하여 Kakao 책 검색 API 호출
func fetchBooks() {
    let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=세이노")!
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = ["Authorization": "KakaoAK 69e56acfc0c35b5b4430df229d2d5c6b"]

    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러 확인
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }

        // 성공적으로 데이터를 받았는지 확인
        guard let data = data else {
            print("No data")
            return
        }

        // 데이터를 파싱합니다.
        do {
            let decodedData = try JSONDecoder().decode(BookSearchResponse.self, from: data)
            // 받아온 책 정보 출력
            for book in decodedData.documents {
                print("Title: \(book.title), Authors: \(book.authors), Contents: \(book.contents), Thumbnail: \(book.thumbnail)")
            }
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
        }
    }.resume()
}


