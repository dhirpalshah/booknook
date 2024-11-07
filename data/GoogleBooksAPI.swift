//
//  GoogleBooksAPI.swift
//  booknook
//
//  Created by Dhirpal Shah on 11/6/24.
//

import Foundation

struct GoogleBooksAPI {
    let apiKey = "AIzaSyBtjMi2oVL8Yo7O_1s9ld10vA1V6fskP14"

    func searchBooks(query: String, completion: @escaping ([Book]) -> Void) {
            let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)&key=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            print("Requesting URL: \(urlString)") // Debugging URL
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data returned from API")
                    return
                }
                
                do {
                    // Print the raw response data for debugging
                    print("Response Data: \(String(data: data, encoding: .utf8) ?? "No readable data")")
                    
                    let decodedResponse = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
                    let books = decodedResponse.items.map { item -> Book in
                        return Book(
                            title: item.volumeInfo.title ?? "No Title",
                            author: item.volumeInfo.authors?.first ?? "Unknown Author",
                            genre: item.volumeInfo.categories?.first ?? "Unknown Genre",
                            rating: Int(item.volumeInfo.averageRating ?? 0)
                        )
                    }
                    DispatchQueue.main.async {
                        completion(books)
                    }
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
}

// Decodable structs for JSON parsing
struct GoogleBooksResponse: Decodable {
    let items: [GoogleBookItem]
}

struct GoogleBookItem: Decodable {
    let volumeInfo: GoogleBookVolumeInfo
}

struct GoogleBookVolumeInfo: Decodable {
    let title: String?
    let authors: [String]?
    let categories: [String]?
    let averageRating: Double?
}
