
import Foundation

@MainActor
final class UpdateViewModel: ObservableObject {
    private let repository = ToDosRepository()
    
    func update(id: Int, name: String) async {
        do {
            try await repository.update(id: id, name: name)
        } catch
    }
}
}
