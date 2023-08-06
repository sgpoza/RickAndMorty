//
//  TextFilter.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 6/8/23.
//

import SwiftUI

struct TextFilter: View {
    var title: String
    @Binding var value: String

    var body: some View {
        FilterRow(title: title, value: $value) {
            TextField(title, text: $value)
                .frame(height: 50.0)
        }
    }
}

struct TextFilter_Previews: PreviewProvider {
    var value: String = ""
    
    static var previews: some View {
        TextFilter(title: "Name", value: .constant(""))
    }
}
