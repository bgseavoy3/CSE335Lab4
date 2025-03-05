//
//  ContentView.swift
//  CSE335Lab4
//
//  Created by bseavoy on 3/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BookViewModel(inputBooksL [])
    @StateObject var bookInc: Int = 0;
    var body: some View {
        NavicationView
        {
            .navigationTitle("BookList")
            .toolbar
            {
                ToolbarItem(placement: navigationBarTrailing)
                {
                    Button("Search",action: 
                          {
                              //bring up search interface
                          })
                }
                ToolBarItem(placement: .bottomBar)
                {
                    HStack
                    {
                        Button("Add", action:
                              {
                                  //bring up add interface
                              })
                        Button("Delete", action:
                              {
                                  //bring up delete interface
                              })
                        .padding()
                        Button("Previous", action:
                              {
                                  //bring up previous book
                              })
                        Button("Next", action:
                              {
                                  //bring up next book
                              })
                    }
            }
            VStack 
            {
                if(viewModel.books.isEmpty())
                {
                    Text("Preview Unavailable")
                    Text("Please Input a Book To Access Preview")
                }
                else
                {
                    ZStack
                    {
                        Rectangle() // edit to make correct size
                        Text("Title: " + viewModel.books[bookInc].title)//make sure it is in middle of rectangle
                        Text("Author: " + viewModel.books[bookInc].author)
                        Text("Genre: " + viewModel.books[bookInc].genre)
                        Text("Price: " + viewModel.books[bookInc].price)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
