import Combine
import SwiftUI

class DessertDetailViewModel: ObservableObject {
    @MainActor @Published var mealDetail: MealDetail? = nil
    @MainActor @Published var expand: Bool = false
    @MainActor @Published var collapsableImage: Image = chevronUpImage
    @MainActor @Published var imageSize: CGFloat = 250
    @MainActor @Published var ingredientsTitle = "Ingredients"
    @MainActor @Published var instructionsTitle = "Instructions"
    @MainActor @Published var errorMessage: String?
    
    let dessertId: String
    private let dataProvider: DetailDataProvider
    private let chevronDownImage = Image(systemName: "chevron.down")
    private static let chevronUpImage = Image(systemName: "chevron.up")
    private var tasks =  [Task<(), Never>]()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        dessertId: String,
        dataProvider: DetailDataProvider = DessertDetailDataProvider()
    ) {
        self.dessertId = dessertId
        self.dataProvider = dataProvider
        sink()
    }
    
    func onDisappear() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        tasks.forEach { $0.cancel() }
        tasks.removeAll()
    }
    
    private func sink() {
        $expand
            .sink { [weak self] expandIsOn in
                guard let self = self else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.collapsableImage = expandIsOn ? DessertDetailViewModel.chevronUpImage : self.chevronDownImage
                }
            }
            .store(in: &cancellables)
    }
    
    func collapsablePressed() {
        let task = Task {
            await MainActor.run {
                expand.toggle()
            }
        }
        tasks.append(task)
    }
    
    func getData() {
        let task =  Task {
            if let result = try? await dataProvider.getDetails(id: dessertId), let firstMeal = result.meals.first {
                let ingredients: [Ingredient] = [
                    .init(name: firstMeal.strIngredient1, measure: firstMeal.strMeasure1),
                    .init(name: firstMeal.strIngredient2, measure: firstMeal.strMeasure2),
                    .init(name: firstMeal.strIngredient3, measure: firstMeal.strMeasure3),
                    .init(name: firstMeal.strIngredient4, measure: firstMeal.strMeasure4),
                    .init(name: firstMeal.strIngredient5, measure: firstMeal.strMeasure5),
                    .init(name: firstMeal.strIngredient6, measure: firstMeal.strMeasure6),
                    .init(name: firstMeal.strIngredient7, measure: firstMeal.strMeasure7),
                    .init(name: firstMeal.strIngredient8, measure: firstMeal.strMeasure8),
                    .init(name: firstMeal.strIngredient9, measure: firstMeal.strMeasure9),
                    .init(name: firstMeal.strIngredient10, measure: firstMeal.strMeasure10),
                    .init(name: firstMeal.strIngredient11, measure: firstMeal.strMeasure11),
                    .init(name: firstMeal.strIngredient12, measure: firstMeal.strMeasure12),
                    .init(name: firstMeal.strIngredient13, measure: firstMeal.strMeasure13),
                    .init(name: firstMeal.strIngredient14, measure: firstMeal.strMeasure14),
                    .init(name: firstMeal.strIngredient15, measure: firstMeal.strMeasure15),
                    .init(name: firstMeal.strIngredient16, measure: firstMeal.strMeasure16),
                    .init(name: firstMeal.strIngredient17, measure: firstMeal.strMeasure17),
                    .init(name: firstMeal.strIngredient18, measure: firstMeal.strMeasure18),
                    .init(name: firstMeal.strIngredient19, measure: firstMeal.strMeasure19)
                ].filter { !$0.measure.isEmpty && !$0.name.isEmpty }
                
               await MainActor.run {
                    mealDetail = .init(
                        id: firstMeal.idMeal,
                        meal: firstMeal.strMeal,
                        instructions: firstMeal.strInstructions,
                        mealThumb: firstMeal.strMealThumb,
                        ingredients: ingredients
                    )
                   errorMessage = nil
                }
            } else {
                await MainActor.run {
                    errorMessage = "Error pull to refresh"
                    mealDetail = nil
                }
            }
        }
        tasks.append(task)
    }
}
