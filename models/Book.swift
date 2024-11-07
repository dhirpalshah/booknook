//
//  Book.swift
//  booknook
//
//  Created by Dhirpal Shah on 11/6/24.
//

import Foundation

struct Book: Identifiable, Codable {
    var id = UUID()
    var title: String
    var author: String
    var genre: String
    var rating: Int
}
