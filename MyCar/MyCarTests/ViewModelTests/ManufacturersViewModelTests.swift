//
//  ManufacturersViewModelTests.swift
//  MyCarTests
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import XCTest
import SwiftyMocky
import RxSwift
@testable import MyCar

class ManufacturersViewModelTests: XCTestCase {

    var sut: ManufacturersViewModel!
    var mockedAPI: CarAPITypeMock!
    var mockedRouter: AppRouterTypeMock!
    
    private var bag: DisposeBag!

    
    override func setUpWithError() throws {
        mockedAPI = CarAPITypeMock()
        mockedRouter = AppRouterTypeMock()
        bag = DisposeBag()
        sut = ManufacturersViewModel(api: mockedAPI, router: mockedRouter)
    }

    override func tearDownWithError() throws {
        bag = nil
        mockedAPI = nil
        sut = nil
    }

    func testFetchSuccess() {
        let responseSubject = PublishSubject<ManufacturerResponse>()
        mockedAPI.given(.fetchManufacturers(page: .any, willReturn: responseSubject))
        
        let exp = expectation(description: "Fetch Manufacturer Success")
        sut.manufacturers.subscribe(onNext: { manufacturers in
            if manufacturers.count > 0 {
                exp.fulfill()
            }
        }).disposed(by: bag)
        sut.fetchManufacturers()
        
        let response = ManufacturerResponse(page: 0, totalPageCount: 10, manufactures: [Manufacture(name: "BMW", id: "130")])
        responseSubject.onNext(response)
        waitForExpectations(timeout: 2) {
            if $0 != nil { XCTFail("Expectation not fulfilled") }
        }
    }
    
    func testFetchError() {
        let responseSubject = PublishSubject<ManufacturerResponse>()
        mockedAPI.given(.fetchManufacturers(page: .any, willReturn: responseSubject))
        
        let exp = expectation(description: "Fetch Manufacturer Error")
        sut.errorObservable.subscribe(onNext: { errorMsg in
            if !errorMsg.isEmpty {
                exp.fulfill()
            }
        }).disposed(by: bag)
        
        sut.fetchManufacturers()
        responseSubject.onError(HTTPNetworkError.other)
        waitForExpectations(timeout: 2) {
            if $0 != nil { XCTFail("Expectation not fulfilled") }
        }
    }
    
    func testNoMoreFetch() {
        let responseSubject = PublishSubject<ManufacturerResponse>()
        mockedAPI.given(.fetchManufacturers(page: .any, willReturn: responseSubject))
        let exp = expectation(description: "Fetch More Logic")
        sut.noMoreFetch.subscribe(onNext: { noMoreFetch in
            if noMoreFetch {
                exp.fulfill()
            }
        }).disposed(by: bag)
        sut.fetchManufacturers()
        let response =  ManufacturerResponse(page: 0, totalPageCount: 1, manufactures: [Manufacture(name: "BMW", id: "130")])
        responseSubject.onNext(response)
        waitForExpectations(timeout: 2) {
            if $0 != nil { XCTFail("Expectation not fulfilled") }
        }
    }

    func testManufacturerSelected() {
        let selectedModel = Manufacture(name: "", id: "")
        sut.manufacturerSelected(source: ViewControllerTypeMock(), manufacture: selectedModel)
        mockedRouter.verify(.navigateToCarModels(source: .any, .any), count: 1)
    }
}
