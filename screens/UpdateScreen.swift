
import SwiftUI

struct UpdateScreen: View {
    @Environment(\.dismiss) private var dismiss

    let toDo: ToDos
    @State private var nameController: String
    @State private var showError = false
    @StateObject private var viewModel = UpdateViewModel()

    init(toDo: ToDos) {
        self.toDo = toDo
        _nameController = State(initialValue: toDo.name)  // textfields dolsun
    }

    var body: some View {
        VStack(spacing: 32) {
            TextField("Name", text: $nameController)
                .textFieldStyle(CustomTextfieldStyle())

            if showError {
                Text("Name can not be empty !").foregroundStyle(AppColors.red)
            }

            Button {
                let trimmed = nameController.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.isEmpty {
                    showError = true
                } else {
                    showError = false
                    if let id = toDo.id {
                        Task { await viewModel.update(id: id, name: trimmed) }
                    }
                    dismiss()
                }
            } label: {
                Text("Update").frame(maxWidth: .infinity)
            }
            .buttonStyle(CustomButtonStyle())

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Update Screen")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    HStack {
                        Image(systemName: "arrow.backward").foregroundColor(AppColors.white)
                        Text("ToDos").foregroundColor(AppColors.white)
                    }
                }
            }
        }
    }
}
