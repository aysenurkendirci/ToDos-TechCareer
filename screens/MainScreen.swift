import SwiftUI

struct MainScreen: View {

    init() {
        NavigationBarStyle.setupNavigationBar()
        DatabaseHelper.copyDatabase()
    }

    @State private var searchText = ""
    @State private var searchTask: Task<Void, Never>?
    @State private var sortAZ = false

    @State private var pendingDelete: ToDos?
    @State private var showDeleteAlert = false

    @StateObject private var viewModel = MainViewModel()

   
    private var displayList: [ToDos] {
        sortAZ
        ? viewModel.toDosList.sorted { $0.name.lowercased() < $1.name.lowercased() }
        : viewModel.toDosList
    }

    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("ToDos")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button { sortAZ.toggle() } label: {
                            Image(systemName: sortAZ
                                  ? "arrow.up.arrow.down.circle.fill"
                                  : "arrow.up.arrow.down.circle")
                                .foregroundColor(AppColors.white)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SaveScreen()) {
                            Image(systemName: "plus").foregroundColor(AppColors.white)
                        }
                    }
                }
                .onAppear { Task { await viewModel.loadToDos() } }
        }
        .tint(AppColors.white)
        .searchable(text: $searchText, prompt: "Search")
        .onChange(of: searchText) { _, text in
            // küçük bir debounce
            searchTask?.cancel()
            searchTask = Task { [text] in
                try? await Task.sleep(nanoseconds: 350_000_000)
                await viewModel.search(searchText: text)
            }
        }
        .alert("Listeden çıkartılsın mı?",
               isPresented: $showDeleteAlert,
               presenting: pendingDelete) { toDelete in
            Button("Sil", role: .destructive) {
                if let id = toDelete.id {
                    Task { await viewModel.delete(id: id) }
                }
                pendingDelete = nil
            }
            Button("İptal", role: .cancel) {
                pendingDelete = nil
            }
        } message: { toDelete in
            Text(toDelete.name)
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if displayList.isEmpty {
            Text("No ToDos Yet !")
                .foregroundStyle(AppColors.textColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            listView
        }
    }

    @ViewBuilder
    private var listView: some View {
        List {
            ForEach(displayList) { toDo in
                NavigationLink(destination: UpdateScreen(toDo: toDo)) {
                    ToDoListItem(toDo: toDo)
                }
            }
            .onDelete { offsets in
                if let idx = offsets.first {
                    pendingDelete = displayList[idx]  
                    showDeleteAlert = true
                }
            }
        }
        .listStyle(.plain)
        .refreshable { await viewModel.loadToDos() }
    }
}
