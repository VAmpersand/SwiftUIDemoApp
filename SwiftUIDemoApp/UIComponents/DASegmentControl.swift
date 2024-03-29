//
//  DASegmentControl.swift
//  SwiftUIDemoApp
//
//  Created by Viktor Prikolota on 18.03.2024.
//

import SwiftUI

struct DASegmentControl: View {

    private var segments: [String]
    @Binding private var currentIndex: Int

    init(segments: [String], currentIndex: Binding<Int>) {
        self.segments = segments
        self._currentIndex = currentIndex
    }

    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(segments.indices, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        currentIndex = index
                    }
                }, label: {
                    Text(segments[index])
                        .font(currentIndex == index ? DAFont.title01 : DAFont.title03)
                        .foregroundStyle(currentIndex == index ? DAColor.contentPrimary : DAColor.buttonTertiary)
                })
                .disabled(currentIndex == index)

                if index != segments.indices.last {
                    Text("/")
                        .font(DAFont.title01)
                        .foregroundStyle(DAColor.contentSecondary)
                }
            }
        }
        .animation(.easeInOut(duration: 0.15), value: currentIndex)
    }
}
