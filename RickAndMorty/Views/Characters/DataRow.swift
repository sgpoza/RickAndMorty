//
//  DataRow.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import SwiftUI

struct DataRow: View {
    var title: String
    var data: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title):")
                .foregroundColor(Color.gray)
            Text(data)
                .lineLimit(nil)
                .padding(.leading, 40.0)
        }
        .font(.title3)
    }
}

struct DataRow_Previews: PreviewProvider {
    
    static var previews: some View {
        DataRow(title: "Origin", data: "Earth")
    }
}
