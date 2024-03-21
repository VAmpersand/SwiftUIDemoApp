//
//  AuthorizationView.swift
//  SwiftUIDemoApp
//
//  Created by Viktor Prikolota on 18.03.2024.
//

import SwiftUI

extension AuthorizationView {
    enum State: Int, CaseIterable {
        case logIn
        case signUp

        var title: String {
            switch self {
            case .logIn: return "Log In"
            case .signUp: return "Sign Up"
            }
        }
    }
}

struct AuthorizationView: View {

    @ObservedObject var viewModel: AuthorizationViewModel

    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            DAColor.backgroundGradient
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                DASegmentControl(segments: AuthorizationView.State.allCases.map(\.title),
                                 currentIndex: $viewModel.currentSegentIndex)

                Spacer()
                    .frame(height: 12)

                TabView(selection: $viewModel.currentSegentIndex) {
                    ForEach(AuthorizationView.State.allCases, id: \.rawValue) { state in
                        switch state {
                        case .logIn: Color.blue
                        case .signUp: Color.red
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 300)

                DATextField(title: "Email",
                            text: $viewModel.emailInput,
                            state: $viewModel.emailState)
            }
            .padding(.horizontal, 45)
        }
    }
}

#Preview {
    AuthorizationView(viewModel: AuthorizationViewModel())
}
