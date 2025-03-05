//
//  ContentView.swift
//  CSE335Lab4
//
//  Created by bseavoy on 3/4/25.
//

import SwiftUI

struct ContentView: View
{
    @StateObject var viewModel = BookViewModel(inputBooks: [])
    @State var bookInc: Int = 0
    @State var showSearch = false
    @State var showSearchResults = false
    @State var showDelete = false
    @State var showFail = false
    @State var showAdd = false
    @State var titleSearchInput = ""
    @State var genreSearchInput = ""
    @State var deleteInput = ""
    @State var tempInc = 0
    @State var inputTitle = ""
    @State var inputAuthor = ""
    @State var inputGenre = ""
    @State var inputPrice = ""
    @State var seeFailAddText = false
    @State var seeFailDelText = false
    var body: some View
    {
        NavigationStack
        {
            
            VStack 
            {
                if(viewModel.books.count == 0)
                {
                    Text("Preview Unavailable")
                    Text("Please Input a Book To Access Preview")
                }
                else
                {
                    ZStack
                    {
                        Rectangle().fill(.green).opacity(0.4).cornerRadius(10)
                        VStack
                        {
                            Text("Title: " + viewModel.books[bookInc].title)//make sure it is in middle of rectangle
                            Text("Author: " + viewModel.books[bookInc].author)
                            Text("Genre: " + viewModel.books[bookInc].genre)
                            Text("Price: " + viewModel.books[bookInc].price)
                        }
                    }
                }
            }
            .navigationTitle("Book List")
            .toolbar
            {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    HStack
                    {
                        Button("Search",action:
                                {
                            showSearch = true
                        })
                    }
                }
                ToolbarItem(placement: .bottomBar)
                {
                    HStack
                    {
                        Button("Add", action:
                        {
                            showAdd = true
                        })
                        Button("Delete", action:
                        {
                            showDelete = true
                        })
                        .padding()
                        Button("Previous", action:
                        {
                            if(bookInc > 0)
                            {
                                bookInc = bookInc - 1
                            }
                            else
                            {
                                showFail = true
                            }
                        })
                        Button("Next", action:
                        {
                            if(bookInc < viewModel.books.count - 1)
                            {
                                bookInc = bookInc + 1
                            }
                            else
                            {
                                showFail = true
                            }
                        })
                    }
                }
            }
            .sheet(isPresented: $showSearch)
            {
                VStack
                {
                    Text("Search by Title:")
                    TextField("Enter Book Title Here", text: $titleSearchInput)
                    Button("Start Title Search", action:
                    {
                        showSearch = false
                        tempInc = viewModel.findBookByTitle(title: titleSearchInput)
                        if(tempInc != -1)
                        {
                            bookInc = tempInc
                            showSearchResults = true
                        }
                        else
                        {
                                showFail = true
                        }
                    })
                    Text("Search by Genre:")
                    TextField("Enter Book Genre Here", text: $genreSearchInput)
                    Button("Start Genre Search", action:
                    {
                        showSearch = false
                        tempInc = viewModel.findBookByGenre(genre: genreSearchInput)
                        if(tempInc != -1)
                        {
                            bookInc = tempInc
                            showSearchResults = true
                        }
                        else
                        {
                            showFail = true
                        }
                    })
                }
            }
            .sheet(isPresented: $showSearchResults)
            {
                VStack
                {
                    Text("Search Successful")
                    Text("Enter Book Information")
                    HStack
                    {
                        Text("Title: ")
                        TextField("", text: $viewModel.books[bookInc].title).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack
                    {
                        Text("Author: ")
                        TextField("",text: $viewModel.books[bookInc].author).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack
                    {
                        Text("Genre: ")
                        TextField("",text: $viewModel.books[bookInc].genre).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack
                    {
                        Text("Price: ")
                        TextField("",text: $viewModel.books[bookInc].price).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button("Enter Info / Exit", action:
                    {
                        showSearchResults = false
                    })
                }
            }
            .alert("Fail", isPresented: $showFail)
            {
                VStack
                {
                    Text("Failure to complete action, please try again")
                    Button("Return", action:
                        {
                            showFail = false
                        })
                }
            }
            .sheet(isPresented: $showAdd)
            {
                VStack
                {
                    Text("Add Book")
                    .padding()
                    HStack
                    {
                        Text("Title: ")
                        TextField("", text: $inputTitle).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack
                    {
                        Text("Author: ")
                        TextField("",text: $inputAuthor).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack
                    {
                        Text("Genre: ")
                        TextField("",text: $inputGenre).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack
                    {
                        Text("Price: ")
                        TextField("",text: $inputPrice).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button("Add Book With New Info", action:
                    {
                        if(inputTitle != "" && inputAuthor != "" && inputAuthor != "" && inputPrice != "")
                        {
                            viewModel.addBook(title: inputTitle, author: inputAuthor, genre: inputGenre, price: inputPrice)
                            showAdd = false
                            inputTitle = ""
                            inputAuthor = ""
                            inputGenre = ""
                            inputPrice = ""
                        }
                        else
                        {
                            showFail = true
                        }
                    })
                }
            }
            .sheet(isPresented:$showDelete)
            {
                VStack
                {
                    Text("Delete Book")
                    Text("Please Enter The Title of The Book Being Deleted")
                    HStack
                    {
                        Text("Title: ")
                        TextField("Enter Title Here", text: $deleteInput).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button("Delete Book", action:
                    {
                        bookInc = 0 // avoids out of index error?
                        if(viewModel.removeBook(title: deleteInput))
                        {
                            seeFailDelText = false
                        }
                        else
                        {
                            showFail = true
                        }
                    })
                }
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
