import Combine
import SwiftUI

class FormViewModel: ObservableObject {
    @Published var provinces: [String] = []
    @Published var cities: [String] = []
    @Published var selectedProvince: String = "Pilih Provinsi"
    @Published var selectedCity: String = "Pilih Kota"
    @Published var searchText = ""
    @Published var name: String = ""
    @Published var isValid: Bool = false
    @Published var navigateToHome: Bool = false

    private var provinceCityMapping: [String: [String]] = [:]
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadProvincesAndCities()
    }

    private func loadProvincesAndCities() {
        provinceCityMapping = [
            "Jawa Barat": ["Bandung", "Bogor", "Bekasi"],
            "DKI Jakarta": ["Jakarta Utara", "Jakarta Barat", "Jakarta Selatan"],
            "Jawa Tengah": ["Semarang", "Solo", "Yogyakarta"]
        ]

        provinces = provinceCityMapping.keys.sorted()
    }

    func cities(for province: String) -> [String] {
        return provinceCityMapping[province] ?? []
    }

//    func validateInputs(name: String, province: String, city: String) -> Bool {
//        return !name.isEmpty && !province.isEmpty && !city.isEmpty
//    }
    
    func validateForm() {
        isValid = !name.isEmpty && selectedProvince != "Pilih Provinsi" && selectedCity != "Pilih Kota"
    }
}
