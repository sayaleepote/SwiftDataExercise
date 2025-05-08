import Foundation
import SwiftData

@Model
final class LoanRecord {
    var dateLoaned: Date
    
    @Relationship(deleteRule: .deny)
    var book: Book

    
    init(book: Book, dateLoaned: Date = Date()) {
        self.book = book
        self.dateLoaned = dateLoaned
    }
} 
