//
//  BookListView.swift
//  booknook
//
//  Created by Dhirpal Shah on 11/6/24.
//

import SwiftUI
import Foundation

struct BookListView: View {
    @State private var books: [Book] = DataManager.shared.loadBooks()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        Text(book.title)
                    }
                }
            }
            .navigationTitle("BookNook")
            .toolbar {
                            #if os(iOS)
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: addBook) {
                                    Image(systemName: "plus")
                                }
                            }
                            #else
                            ToolbarItem {
                                Button(action: addBook) {
                                    Image(systemName: "plus")
                                }
                            }
                            #endif
                        }
        }
    }
    
    func addBook() {
        // For now, you can add a placeholder book
        let newBook = Book(title: "Sample Book", author: "Author Name", genre: "Genre", rating: 5)
        books.append(newBook)
        DataManager.shared.saveBooks(books)
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
