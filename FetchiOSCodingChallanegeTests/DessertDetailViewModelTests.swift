import XCTest
import Combine
@testable import FetchiOSCodingChallanege

final class DessertDetailViewModelTests: XCTestCase {
    var vm: DessertDetailViewModel? = nil
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        vm = .init(dessertId: "")
    }

    override func tearDownWithError() throws {
        vm = nil
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    func testDessertDetailViewModel_init_updatesDessertId() throws {
        // given
        let dessertId = UUID().uuidString
        // when
        vm = .init(dessertId: dessertId)
        guard let vm else {
            return
        }
        // then
        XCTAssertTrue(vm.dessertId == dessertId)
    }

    func testDessertDetailViewModel_collapsablePressed_expandValueToggled() async throws {
        // given
        guard let vm else {
            return
        }
        // when
        var expand = await vm.expand
        expand.toggle()
        // then
        let expandToggled = await vm.expand
        XCTAssertFalse(expand == expandToggled)
    }
    
    func testDessertDetailViewModel_getData_updatesMealDetail() async throws {
        //given
        let dessertId = UUID().uuidString
        vm = .init(dessertId: dessertId, dataProvider: MockDetailDataProvider())
        guard let vm else {
            return
        }
        // when
        let expectation = XCTestExpectation(description: "expectation")
        vm.$mealDetail
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.getData()
        await fulfillment(of: [expectation])
        // then
        let mealDetail = await vm.mealDetail
        let errorMessage = await vm.errorMessage
        XCTAssertNotNil(mealDetail)
        XCTAssertNil(errorMessage)
    }
    
    func testDessertDetailViewModel_getData_updatesErrorMessage() async throws {
        //given
        let dessertId = UUID().uuidString
        vm = .init(dessertId: dessertId, dataProvider: MockThrowingDetailDataProvider())
        guard let vm else {
            return
        }
        // when
        let expectation = XCTestExpectation(description: "expectation")
        vm.$errorMessage
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.getData()
        await fulfillment(of: [expectation])
        // then
        let errorMessage = await vm.errorMessage
        let mealDetail = await vm.mealDetail
        XCTAssertNotNil(errorMessage)
        XCTAssertNil(mealDetail)
    }
}
