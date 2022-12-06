//
//  SearchField.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI

struct SearchField: View {
    var label: String = "Search for show"
    @Binding var searchText: String
    @State var focused: Bool = false
    var onEditingChanged: (Bool) -> Void = { _ in }

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
                .foregroundColor(.gray)

            TextField(label,
                      text: $searchText,
                      onEditingChanged: { edit in
                focused = edit
                onEditingChanged(edit)
            })
            .foregroundColor(.black)
            .frame(height: 35)
            .disableAutocorrection(true)

            if searchText != "" {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.trailing, 8)
                }
            }
        }
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 3))
        .foregroundColor(.black.opacity(0.5))
        .background(Color.white)
        .cornerRadius(10.0)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(focused ? Color.black : .gray, lineWidth: 1)
        )
        .padding(.bottom, 8)
    }
}


struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(searchText: .constant("Girl"))
    }
}
