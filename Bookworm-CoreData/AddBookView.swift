//
//  AddBookView.swift
//  Bookworm-CoreData
//
//  Created by Brando Lugo on 2/9/21.
//

import SwiftUI

struct AddBookView: View {
    
    //Tracks the presentation mode used for
    //dismissing the screen after adding a book
    @Environment(\.presentationMode) var presentationMode
    
    //Stores the managed object context
    @Environment(\.managedObjectContext) var moc
    
    //Form will store all data required to make up a book
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    //Store all possible genre options
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                //MARK: BOOK TITLE & AUTHOR SECTION
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre, content: {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    })
                }
                
                //MARK: RATING & REVIEW SECTION
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                
                //MARK: SAVE SECTION
                Section {
                    Button("Save", action: {
                        //ADD Book
                        let newBook = Book(context: self.moc)
                        
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        
                        try? self.moc.save()
                        
                        //Dismiss the the view and return to context
                        self.presentationMode.wrappedValue.dismiss()
                    })
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
