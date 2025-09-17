

import Foundation
import SwiftUI

struct NavigationBarStyle {
    static func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppColors.mainColor)

        let titleFont = UIFont(name: "Oswald-Regular", size: 22)
            ?? UIFont.systemFont(ofSize: 22, weight: .semibold)
        let largeTitleFont = UIFont(name: "Oswald-Regular", size: 32)
            ?? UIFont.systemFont(ofSize: 32, weight: .bold)

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.white),
            .font: titleFont
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(AppColors.white),
            .font: largeTitleFont
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
