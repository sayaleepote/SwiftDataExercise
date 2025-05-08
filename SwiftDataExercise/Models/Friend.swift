import Foundation
import SwiftData

@Model
final class Friend {
    var name: String
    var contactNumber: String?
    
    @Relationship(deleteRule: .cascade, inverse: \LoanRecord.friend)
    var loanRecords: [LoanRecord]?
    
    init(name: String, contactNumber: String? = nil) {
        self.name = name
        self.contactNumber = contactNumber
    }
} 