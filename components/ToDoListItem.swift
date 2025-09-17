
import SwiftUI

struct ToDoListItem: View {
    var toDo = ToDos()

    var body: some View {
        HStack {
            Text(toDo.name )
                .foregroundStyle(AppColors.textColor)
        }
        .padding(8)
    }
}
