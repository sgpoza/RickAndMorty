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
    var titleSize: CGFloat = 80.0
    var content: () -> Content
    
    init(title: String, value: Binding<String>, titleSize: CGFloat = 80.0, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.value = value
        self.titleSize = titleSize
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("\(title):")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: titleSize, alignment: .leading)
                content() // Use the content closure to provide the specific view
                Spacer()
            }
            Divider()
        }
        .frame(height: 50.0)
    }
}
