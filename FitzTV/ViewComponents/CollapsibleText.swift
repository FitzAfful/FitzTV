//
//  CollapsibleText.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import SwiftUI

struct CollapsableText: View {
    let lineLimit: Int

    @State private var expanded: Bool = false
    @State private var showViewButton: Bool = false
    private var text: String

    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit

    }

    private var moreLessText: String {
        if showViewButton {
            return expanded ? "View Less" : "View More"

        } else {
            return ""

        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Text(text)
                    .font(.system(size: 14))
                    .lineSpacing(4)
                    .lineLimit(expanded ? nil : lineLimit)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                ScrollView(.vertical) {
                    Text(text)
                        .font(.body)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        showViewButton = proxy.size.height > CGFloat(22 * lineLimit)
                                    }
                                    .onChange(of: text) { _ in
                                        showViewButton = proxy.size.height > CGFloat(22 * lineLimit)
                                    }
                            }
                        )

                }
                .opacity(0.0)
                .disabled(true)
                .frame(height: 0.0)
            }

            Button(action: {
                withAnimation {
                    expanded.toggle()
                }
            }, label: {
                Text(moreLessText)
                    .font(.system(size: 14))
                    .lineSpacing(4)
                    .lineLimit(expanded ? nil : lineLimit)
                    .foregroundColor(.orange)
                    .padding(.horizontal)
            })
            .opacity(showViewButton ? 1.0 : 0.0)
            .disabled(!showViewButton)
            .frame(height: showViewButton ? nil : 0.0)
        }
        .padding(.bottom)
    }
}

struct CollapsableText_Previews: PreviewProvider {
    static var previews: some View {
        CollapsableText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", lineLimit: 3)
    }

}
