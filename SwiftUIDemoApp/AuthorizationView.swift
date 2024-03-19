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

            VStack {
                DASegmentControl(segments: ["Log In", "Sign Up"],
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
                .frame(height: 300)
            }
        }
    }
}

#Preview {
    AuthorizationView(viewModel: AuthorizationViewModel())
}
