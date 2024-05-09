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
}

struct BookSearchResponse: Codable {
    let documents: [Book]
}
