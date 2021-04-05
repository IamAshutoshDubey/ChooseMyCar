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
    
    private var bag: DisposeBag!

    
    override func setUpWithError() throws {
        mockedAPI = CarAPITypeMock()
        bag = DisposeBag()
        sut = ManufacturersViewModel(api: mockedAPI)
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
        sut.manufacturersObservable.subscribe(onNext: { manufacturers in
            if manufacturers.count > 0 {
                exp.fulfill()
            }
        }).disposed(by: bag)
        sut.fetchManufacturers()
        
        let response =  ManufacturerResponse(page: 0, totalPageCount: 10, manufactures: [Manufacture(name: "BMW", id: "130")])
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
    
    func testFetchMoreLogic() {
        let responseSubject = PublishSubject<ManufacturerResponse>()
        mockedAPI.given(.fetchManufacturers(page: .any, willReturn: responseSubject))
        let exp = expectation(description: "Fetch More Logic")
        sut.manufacturersObservable.subscribe(onNext: { [weak self] errorMsg in
            guard let weakself = self else {return}
            if weakself.sut.shouldFetchMore == false {
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
        
    }
}
