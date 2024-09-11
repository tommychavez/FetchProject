import SwiftUI

class DessertListViewModel: ObservableObject {
    @MainActor @Published var desserts: [Dessert] = []
    @MainActor @Published var imageSize: CGFloat = 100
    @MainActor @Published var navigationTitle: String = "Desserts"
    
    let dataProvider: DessertListDataProvider
    
    init(dataProvider: DessertListDataProvider = DessertListDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func getData() {
        Task {
            let response = try? await dataProvider.getDesserts()
            if let response {
                let desserts: [Dessert] = response.meals.map {
                    .init(
                        id: $0.idMeal,
                        title: $0.strMeal,
                        imageUrl: $0.strMealThumb
                    )
                }
                    .sorted {
                        $0.title < $1.title
                    }
                await MainActor.run {
                    self.desserts = desserts
                }
            }
        }
    }
}
