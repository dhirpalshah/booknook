//
//  ISBNdbAPI.swift
//  booknook
//
//  Created by Dhirpal Shah on 11/7/24.
//

import Foundation

struct ISBNdbAPI {
    let apiKey = "56873_9890ff9ba473c96c2071d27a2a4b6420" // Replace with your actual API key

    func searchBooks(query: String, completion: @escaping ([Book]) -> Void) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api2.isbndb.com/books/\(query)"
        
        // Print the URL for debugging purposes
        print("Requesting URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data returned from API")
                return
            }
            
            // Print raw JSON data for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            // Parse JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(ISBNdbResponse.self, from: data)
                let books = decodedResponse.books.map { item -> Book in
                    return Book(
                        title: item.title,
                        author: item.authors.first ?? "Unknown Author",
                        genre: item.subjects.first ?? "Unknown Genre",
                        rating: 0 // ISBNdb does not provide a rating
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
struct ISBNdbResponse: Decodable {
    let books: [ISBNdbBook]
}

struct ISBNdbBook: Decodable {
    let title: String
    let authors: [String]
    let subjects: [String]
}
