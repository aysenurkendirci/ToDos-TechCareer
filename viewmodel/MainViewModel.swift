
import Foundation

@MainActor
class MainViewModel: ObservableObject {
    private let repository = ToDosRepository()
    @Published var toDosList: [ToDos] = []
    
    func loadToDos() async {
        do { toDosList = try await repository.loadToDos() }
        catch { toDosList = [] }
    }
    
    func search(searchText: String) async {
        do { toDosList = try await repository.search(searchText) }
        catch { toDosList = [] }
    }
    
    func delete(id: Int) async {
        try? await repository.delete(id: id)
        await loadToDos()
    }
}
