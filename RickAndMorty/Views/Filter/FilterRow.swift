//
//  FilterRow.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 6/8/23.
//

import SwiftUI

struct FilterRow<Content: View>: View {
    var title: String
    var value: Binding<String>
    var titleSize: CGFloat
    var content: () -> Content
    
    init(title: String, value: Binding<String>, titleSize: CGFloat = 80.0, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.value = value
        self.titleSize = titleSize
        self.content = content
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title):")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: titleSize, alignment: .leading)
                content()
                Spacer()
            }
            Spacer()
            Divider()
        }
        .frame(height: 50.0)
    }
}
