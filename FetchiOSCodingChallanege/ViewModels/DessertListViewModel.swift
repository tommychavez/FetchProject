import SwiftUI

class DessertListViewModel: ObservableObject {
    @MainActor @Published var meals: [Meal] = []
    @MainActor @Published var imageSize: CGFloat = 100
    @MainActor @Published var navigationTitle: String = "Desserts"
    @MainActor @Published var errorMessage: String?
    
    private let dataProvider: ListDataProvider
    private var tasks =  [Task<(), Never>]()
    
    init(dataProvider: ListDataProvider = DessertListDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func onDisappear() {
        tasks.forEach { $0.cancel() }
        tasks.removeAll()
    }
    
    func getData() {
      let task = Task {
          if let response = try? await dataProvider.getList(), !response.meals.isEmpty {
                let meals: [Meal] = response.meals.map {
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
                    self.meals = meals
                    self.errorMessage = nil
                }
            } else {
                await MainActor.run {
                    errorMessage = "Error pull to refresh"
                    meals = []
                }
            }
        }
        tasks.append(task)
    }
}
