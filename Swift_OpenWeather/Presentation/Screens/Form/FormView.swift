import SwiftUI
import SwiftData

struct FormView: View {
    @StateObject private var viewModel = FormViewModel()
    @EnvironmentObject var networkManager : NetworkManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Nama Lengkap", text: $viewModel.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                
                CustomPicker(type: .province, options: viewModel.provinces.map{$0.name})
                        .environmentObject(viewModel)
                CustomPicker(type: .city, options: viewModel.cities.map{$0.name})
                        .environmentObject(viewModel)
                
                Button("Proses") {
                    if viewModel.isValid {
                        viewModel.navigateToHome = true
                    } else {
                        // Show validation error
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.isValid)
            }
            .padding()
            .navigationTitle("Pengisian Data")
            .navigationDestination(isPresented: $viewModel.navigateToHome, destination: {
                HomeView(name: $viewModel.name, city: $viewModel.selectedCity)
            })
            .sheet(isPresented: $viewModel.isSelectingProvince, content: {
                SearchableDropdown(type: .province, options: viewModel.provinces.map{$0.name})
                    .environmentObject(viewModel)
                    .environmentObject(networkManager)
            })
            .sheet(isPresented: $viewModel.isSelectingCity, content: {
                SearchableDropdown(type: .city, options: viewModel.cities.map{$0.name})
                    .environmentObject(viewModel)
                    .environmentObject(networkManager)
            })
            .task {
                do {
                    try await viewModel.getProvinces()
                } catch {
                    print("Error catching data")
                }
            }
            .onChange(of: viewModel.name) { viewModel.validateForm() }
            .onChange(of: viewModel.selectedProvince) {
                viewModel.selectedCity = "Pilih Kota"
                Task {
                    try await viewModel.getCities()
                }
                viewModel.validateForm()
            }
            .onChange(of: viewModel.selectedCity) { viewModel.validateForm() }
        }
    }
}

#Preview {
    FormView()
        .environmentObject(NetworkManager())
}
