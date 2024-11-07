//
//  DataManager.swift
//  booknook
//
//  Created by Dhirpal Shah on 11/6/24.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    func saveBooks(_ books: [Book]) {
        if let encoded = try? JSONEncoder().encode(books) {
            UserDefaults.standard.set(encoded, forKey: "savedBooks")
        }
    }
    
    func loadBooks() -> [Book] {
        if let savedData = UserDefaults.standard.data(forKey: "savedBooks"),
           let decodedBooks = try? JSONDecoder().decode([Book].self, from: savedData) {
            return decodedBooks
        }
        return []
    }
}
