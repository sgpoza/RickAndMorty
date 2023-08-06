//
//  FilterView.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 6/8/23.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var service: APIService
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel", role: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Reset") {
                    service.filters = FilterData()
                    service.setFilters()
                }
                Button("Save") {
                    service.setFilters()
                    service.getCharacters()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.leading, 20.0)
            }
            .padding()
            ScrollView {
                VStack {
                    TextFilter(title: "Name", value: $service.filters.name)
                    PickerFilter(title: "Status", value: $service.filters.status, options: Status.allCases.map { $0.rawValue })
                    TextFilter(title: "Species", value: $service.filters.species)
                    TextFilter(title: "Type", value: $service.filters.type)
                    PickerFilter(title: "Gender", value: $service.filters.gender, options: Gender.allCases.map { $0.rawValue })
                }
            }
            .padding()
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
            .environmentObject(APIService())
    }
}
