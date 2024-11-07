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
    var onBookSelected: (Book) -> Void

    var body: some View {
        VStack {
            TextField("Search for a book...", text: $query, onCommit: searchBooks)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

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
    
    func searchBooks() {
        GoogleBooksAPI().searchBooks(query: query) { books in
            searchResults = books
        }
    }
}

struct BookSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView { _ in }
    }
}
