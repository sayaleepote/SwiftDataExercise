import SwiftUI
import SwiftData

struct AddLoanRecordView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var books: [Book]
    
    @State private var selectedBook: Book?
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
                        if let book = selectedBook{
                            let record = LoanRecord(book: book, dateLoaned: dateLoaned)
                            modelContext.insert(record)
                            dismiss()
                        }
                    }
                    .disabled(selectedBook == nil)
                }
            }
        }
    }
} 
