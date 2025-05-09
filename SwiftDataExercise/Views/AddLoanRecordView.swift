import SwiftUI
import SwiftData

struct AddLoanRecordView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var books: [Book]
    @Query private var friends: [Friend]
    
    @State private var selectedBook: Book?
    @State private var selectedFriend: Friend?
    @State private var dateLoaned = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Book", selection: $selectedBook) {
                    Text("Select a book").tag(nil as Book?)
                    ForEach(books) { book in
                        Text(book.title).tag(book as Book?)
                    }
                }
                
                Picker("Friend", selection: $selectedFriend) {
                    Text("Select a friend").tag(nil as Friend?)
                    ForEach(friends) { friend in
                        Text(friend.name).tag(friend as Friend?)
                    }
                }
                
                DatePicker("Date Loaned", selection: $dateLoaned, displayedComponents: [.date, .hourAndMinute])
            }
            .navigationTitle("Add Loan Record")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if let book = selectedBook, let friend = selectedFriend {
                            let record = LoanRecord(book: book, friend: friend, dateLoaned: dateLoaned)
                            modelContext.insert(record)
                            dismiss()
                        }
                    }
                    .disabled(selectedBook == nil || selectedFriend == nil)
                }
            }
        }
    }
} 