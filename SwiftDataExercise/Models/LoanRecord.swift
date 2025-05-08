import Foundation
import SwiftData

@Model
final class LoanRecord {
    var dateLoaned: Date
    
    @Relationship(deleteRule: .deny)
    var book: Book
    
    @Relationship(deleteRule: .deny)
    var friend: Friend
    
    init(book: Book, friend: Friend, dateLoaned: Date = Date()) {
        self.book = book
        self.friend = friend
        self.dateLoaned = dateLoaned
    }
} 
