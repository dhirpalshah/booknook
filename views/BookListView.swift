import SwiftUI

struct BookListView: View {
    @State private var books: [Book] = DataManager.shared.loadBooks()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        HStack {
                            Text(book.title)
                                .font(.body)
                            Spacer()
                            Text("\(book.rating)/5")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteBook)
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
        let searchView = BookSearchView { selectedBook in
            books.append(selectedBook)
            DataManager.shared.saveBooks(books)
        }
        let newBook = Book(title: "Sample Book", author: "Author Name", genre: "Genre", rating: 5)
        books.append(newBook)
        DataManager.shared.saveBooks(books)
    }
    
    func deleteBook(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
        DataManager.shared.saveBooks(books)
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
