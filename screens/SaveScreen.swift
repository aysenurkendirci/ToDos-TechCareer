
import SwiftUI

struct SaveScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var nameController = ""
    @State private var showError = false
    @StateObject private var viewModel = SaveViewModel()

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
                    Task {
                        await viewModel.save(name: trimmed)
                        dismiss()                              
                    }
                }
            } label: {
                Text("Save").frame(maxWidth: .infinity)
            }
            .buttonStyle(CustomButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Save Screen")
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
