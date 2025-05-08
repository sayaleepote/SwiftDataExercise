import SwiftUI
import SwiftData

struct LoanRecordsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var loanRecords: [LoanRecord]
    @State private var showingAddSheet = false
    @State private var sortOrder: SortOrder = .dateLoaned
    
    enum SortOrder {
        case bookName, dateLoaned
    }
    
    var sortedRecords: [LoanRecord] {
        switch sortOrder {
        case .bookName:
            return loanRecords.sorted { $0.book.title < $1.book.title }
        case .dateLoaned:
            return loanRecords.sorted { $0.dateLoaned > $1.dateLoaned }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedRecords) { record in
                    LoanRecordRow(record: record)
                }
                .onDelete(perform: deleteRecords)
            }
            .navigationTitle("Loan Records")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Sort by Book", action: { sortOrder = .bookName })
                        Button("Sort by Date Loaned", action: { sortOrder = .dateLoaned })
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Label("Add Record", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddLoanRecordView()
            }
        }
    }
    
    private func deleteRecords(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sortedRecords[index])
            }
        }
    }
}

struct LoanRecordRow: View {
    let record: LoanRecord
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(record.book.title)
                .font(.headline)
            Text("Loaned: \(record.dateLoaned.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption)
        }
    }
} 
