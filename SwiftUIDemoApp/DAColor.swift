//
//  DAColor.swift
//  SwiftUIDemoApp
//
//  Created by Viktor Prikolota on 18.03.2024.
//

import SwiftUI

enum DAColor {
    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color("gradientLayer01"),
            Color("gradientLayer02"),
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let background = Color("background")
    static let layer01 = Color("layer01")

    static let contentPrimary = Color("contentPrimary")
    static let contentSecondary = Color("contentSecondary")
    static let contentTertiary = Color("contentTertiary")

    static let contentAccent = Color("contentAccent")

    static let contentWarning = Color.red // TODO: - Add color
    static let contentOnColorPrimary = Color("contentOnColorPrimary")
    static let contentOnColorSecondary = Color("contentOnColorSecondary")

    static let buttonPrimary = Color("buttonPrimary")
    static let buttonSecondary = Color("buttonSecondary")
    static let buttonTertiary = Color("buttonTertiary")

    static let borderRegular = Color("borderRegular")
    static let shadowRegular = Color("shadowRegular")
}


