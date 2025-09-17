
import Foundation

@MainActor //ana threadde güncellensin
final class SaveViewModel: ObservableObject {
    private let repository = ToDosRepository()

    @Published var isSaving = false //@Published değer değiştikçe otomatik uı güncellensin
    @Published var errorMessage: String?

    //trimmingCharacters(in: .whitespacesAndNewlines):başındaki sonundaki boşlukları temizler
    func save(name: String) async -> Bool {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = "Name boş olamaz."
            return false
        }

        isSaving = true
        defer { isSaving = false }

        do {
            try await repository.save(name: trimmed)
            errorMessage = nil
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
