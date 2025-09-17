
import Foundation
import SwiftUI

struct CustomButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(AppColors.mainColor)
            .foregroundStyle(AppColors.white)
            .cornerRadius(8)
    }
}
