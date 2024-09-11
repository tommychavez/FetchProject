import SwiftUI

struct DessertListDataProvider: ListDataProvider {
    func getList() async throws -> MealsDTO {
        try await DataProvider().getData(apiEndpoint: .categories(id: "Dessert"))
    }
}
