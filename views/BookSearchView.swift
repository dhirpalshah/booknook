//
//  BookSearchView.swift
//  booknook
//
//  Created by Dhirpal Shah on 11/6/24.
//

import Foundation
import SwiftUI

struct BookSearchView: View {
    @State private var query = ""
    @State private var searchResults: [Book] = []
    @Environment(\.presentationMode) var presentationMode
    let api = ISBNdbAPI()  // Initialize the ISBNdbAPI
    var onBookSelected: (Book) -> Void

    var body: some View {
        VStack {
            // Search Bar
            TextField("Search for a book...", text: $query, onCommit: performSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // List of Search Results
            List(searchResults) { book in
                Button(action: {
                    onBookSelected(book)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Search Books")
    }
    
    // Call the searchBooks function from ISBNdbAPI
    func performSearch() {
        api.searchBooks(query: query) { books in
            searchResults = books  // Update the results to show in the list
        }
    }
}

struct BookSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView { _ in }
    }
}
