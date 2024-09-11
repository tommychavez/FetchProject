import SwiftUI

struct MockThrowingListDataProvider: ListDataProvider {
    func getList() async throws -> MealsDTO {
        throw URLError(.unknown)
    }
}
