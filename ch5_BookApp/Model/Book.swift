//
//  Book.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/9/24.
//
import Foundation

struct Book: Codable {
    let title: String
    let authors: [String]
    let contents: String
    let thumbnail: String
    let price: Int // 정가
    let salePrice: Int // 할인 가격

    enum CodingKeys: String, CodingKey {
        case title, authors, contents, thumbnail, price
        case salePrice = "sale_price" // API 응답에서의 필드명과 매핑
    }
}

struct BookSearchResponse: Codable {
    let documents: [Book]
}

