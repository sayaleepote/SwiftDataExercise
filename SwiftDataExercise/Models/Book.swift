import Foundation
import SwiftData

@Model
final class Book {
    var title: String
    var author: String
    
    @Relationship(deleteRule: .cascade, inverse: \LoanRecord.book)
    var loanRecords: [LoanRecord]?
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
} 