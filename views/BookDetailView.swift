//
//  BookDetailView.swift
//  booknook
//
//  Created by Dhirpal Shah on 11/6/24.
//

import Foundation
import SwiftUI

struct BookDetailView: View {
    var book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(book.title).font(.largeTitle).bold()
            Text("Author: \(book.author)")
            Text("Genre: \(book.genre)")
            Text("Rating: \(book.rating)/5")
        }
        .padding()
        .navigationTitle("Book Details")
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(title: "Sample Book", author: "Author Name", genre: "Genre", rating: 4))
    }
}
