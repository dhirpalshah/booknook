import Foundation


// Root response structure for Google Books API
struct GoogleBooksResponse: Decodable {
    let items: [GoogleBookItem]
}

// Each item in the Google Books response
struct GoogleBookItem: Decodable {
    let volumeInfo: GoogleBookVolumeInfo
}

// Detailed information about each book
struct GoogleBookVolumeInfo: Decodable {
    let title: String?
    let authors: [String]?
    let categories: [String]?
    let averageRating: Double?
}

struct GoogleBooksAPI {
    let apiKey = "AIzaSyBrxCiTDMDnE4RZPfaF-OUIaYkzHNvKhZ8"

    func searchBooks(query: String, completion: @escaping ([Book]) -> Void) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)&key=\(apiKey)"
        
        // Debugging - Print URL
        print("Requesting URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            // Check if data is not nil
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Print raw JSON data as a string for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            // Parse JSON using JSONSerialization
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let items = jsonObject["items"] as? [[String: Any]] {
                    for item in items {
                        print("Item: \(item)") // Print each item in JSON response
                    }
                }
            } catch {
                print("Failed to parse JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
