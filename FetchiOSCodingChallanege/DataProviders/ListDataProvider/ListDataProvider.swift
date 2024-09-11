import SwiftUI

protocol ListDataProvider {
    func getList() async throws -> MealsDTO
}
