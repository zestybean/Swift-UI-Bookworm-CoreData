//
//  ContentView.swift
//  Bookworm-CoreData
//
//  Created by Brando Lugo on 2/8/21.
//

import SwiftUI

struct ContentView: View {
    
    //Core data stuff
    @Environment(\.managedObjectContext) var moc
    
    //Fetch request gets the model from core data and NSSort sorts the data using
    //the descriptors
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true), NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
    
    //Tracks wether the sheet is showing
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(
                        destination: DetailView(book: book),
                        label: {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        })
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationBarTitle("Bookworm")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }, label: {
                    Image(systemName: "plus")
                }))
                .sheet(isPresented: $showingAddScreen, content: {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                })
        }
    }
    
    //Delete from a core data fetch request
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            //Find this bok in our fetch request
            let book = books[offset]
            
            //Delete from context
            moc.delete(book)
        }
        
        //Save the context
        try? moc.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
