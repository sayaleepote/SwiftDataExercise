import SwiftUI
import SwiftData

struct FriendsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var friends: [Friend]
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    VStack(alignment: .leading) {
                        Text(friend.name)
                            .font(.headline)
                        if let contact = friend.contactNumber {
                            Text(contact)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteFriends)
            }
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Label("Add Friend", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddFriendView()
            }
        }
    }
    
    private func deleteFriends(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(friends[index])
            }
        }
    }
}

struct AddFriendView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var contactNumber = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Contact Number (Optional)", text: $contactNumber)
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let friend = Friend(name: name, contactNumber: contactNumber.isEmpty ? nil : contactNumber)
                        modelContext.insert(friend)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
} 