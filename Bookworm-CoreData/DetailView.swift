//
//  DetailView.swift
//  Bookworm-CoreData
//
//  Created by Brando Lugo on 2/10/21.
//

import SwiftUI
//Needed for preview
import CoreData

struct DetailView: View {
    
    //Show this book
    let book: Book
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                //TOP
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                        .cornerRadius(15.0)
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                //BOTTOM
                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "No Review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Book"
        book.author = "Test Author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a really great fake book!"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
