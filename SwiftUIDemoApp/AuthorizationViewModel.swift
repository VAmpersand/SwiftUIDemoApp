//
//  AuthorizationViewModel.swift
//  SwiftUIDemoApp
//
//  Created by Viktor Prikolota on 18.03.2024.
//

import SwiftUI
import Combine

final class AuthorizationViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    @Published var currentSegentIndex = 1

    @Published var emailInput: String = ""
    @Published var emailState = DATextField.InputState.regular(message: "aa@aa.aa")

    init() {
        bind()
    }

    private func bind() {
        $currentSegentIndex
            .sink { value in
                print("Action \(value)")
            }
            .store(in: &cancellables)

        $emailInput
            .sink { value in
                print(value)

            }
            .store(in: &cancellables)
    }
}
