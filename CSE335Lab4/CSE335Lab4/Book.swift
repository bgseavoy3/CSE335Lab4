//
//  Book.swift
//  CSE335Lab4
//
//  Created by bseavoy on 3/4/25.
//
import SwiftUI
struct Book
{
    
    var title: String
    var author: String
    var genre: String
    var price: String
}
class BookViewModel: ObservableObject
{
    @Published var books: [Book]
    
    init(inputBooks: [Book])
    {
        books = inputBooks
    }
    
    func addBook(title: String, author: String, genre: String, price: String)
    {
        let nBook = Book(title: title, author: author, genre: genre, price: price)
        books.append(nBook)
    }
    func findBookByTitle(title: String) -> Int
    {
        for i in 0..<books.count
        {
            if(books[i].title == title)
            {
                return i
            }
        }
        return -1
    }
    func findBookByGenre(genre: String) -> Int
    {
        for i in 0..<books.count
        {
            if(books[i].genre == genre)
            {
                return i
            }
        }
        return -1
    }
    func removeBook(title: String) -> Bool
    {
        var index: Int = findBookByTitle(title: title)
        if(index != -1)
        {
            books.remove(at: index)
            return true
        }
        else
        {
            return false
        }
    }
}
