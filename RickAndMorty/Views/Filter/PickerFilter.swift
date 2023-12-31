//
//  PickerFilter.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 6/8/23.
//

import SwiftUI

struct PickerFilter: View {
    var title: String
    @Binding var value: String
    var options: [String]

    var body: some View {
        FilterRow(title: title, value: $value) {
            Picker(title, selection: $value) {
                Text("All").tag("")
                ForEach(options, id: \.self) { element in
                    Text(element.capitalized).tag(element)
                }
            }
            .padding(.leading, -12.0)
            .frame(height: 50.0)
        }
    }
}

struct PickerFilter_Previews: PreviewProvider {
    static var previews: some View {
        PickerFilter(title: "Status", value: .constant(""), options: Status.allCases.map { $0.rawValue })
    }
}
