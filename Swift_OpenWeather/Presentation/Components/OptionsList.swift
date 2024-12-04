//
//  OptionsList.swift
//  Swift_OpenWeather
//
//  Created by Balya Elfata on 04/12/24.
//

import SwiftUI

struct OptionsList: View {
    @EnvironmentObject var viewModel: FormViewModel
    var type: DropdownType
    let options: [String]

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { option in
                    Button {
                        if type == .province {
                            viewModel.selectedProvince = option
                            viewModel.provinceCode = viewModel.provinces.first(where: { $0.name == viewModel.selectedProvince })?.code ?? ""
                            viewModel.isSelectingProvince = false
                        } else {
                            viewModel.selectedCity = option
                            viewModel.isSelectingCity = false
                        }
                    } label: {
                        Text(option)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText)
    }

    var searchResults: [String] {
        if viewModel.searchText.isEmpty {
            return options
        } else {
            return options.filter { $0.contains(viewModel.searchText) }
        }
    }
}

#Preview {
    OptionsList(type: .province, options: ["Holly", "Josh", "Rhonda", "Ted"])
        .environmentObject(FormViewModel())
}
