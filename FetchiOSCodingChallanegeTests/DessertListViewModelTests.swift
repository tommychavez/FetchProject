import XCTest
import Combine
@testable import FetchiOSCodingChallanege

final class DessertListViewModelTests: XCTestCase {
    var vm: DessertListViewModel? = nil
    var cancellables = Set<AnyCancellable>()
    
    override func tearDownWithError() throws {
        vm = nil
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func testDessertListViewModel_getData_updatesMeals() async throws {
        // given
        vm = .init(dataProvider: MockListDataProvider())
        guard let vm else {
            return
        }
        // when
        let expectation = XCTestExpectation(description: "expectation")
        vm.$meals
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.getData()
        await fulfillment(of: [expectation])
        // then
        let meals = await vm.meals
        let errorMessage = await vm.errorMessage
        XCTAssertTrue(!meals.isEmpty)
        XCTAssertNil(errorMessage)
    }
    
    func testDessertListViewModel_getData_updatesErrorMessage() async throws {
        // given
        vm = .init(dataProvider: MockThrowingListDataProvider())
        guard let vm else {
            return
        }
        // when
        let expectation = XCTestExpectation(description: "expectation")
        vm.$meals
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.getData()
        await fulfillment(of: [expectation])
        // then
        let errorMessage = await vm.errorMessage
        let meals = await vm.meals
        XCTAssertNotNil(errorMessage)
        XCTAssertTrue(meals.isEmpty)
    }
}
