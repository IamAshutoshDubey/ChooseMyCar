//
//  CarModelsViewModelTests.swift
//  MyCarTests
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import XCTest
import SwiftyMocky
import RxSwift
@testable import MyCar

class CarModelsViewModelTests: XCTestCase {

    var sut: CarModelsViewModel!
    var mockedAPI: CarAPITypeMock!
    
    private var bag: DisposeBag!

    
    override func setUpWithError() throws {
        mockedAPI = CarAPITypeMock()
        bag = DisposeBag()
        sut = CarModelsViewModel(api: mockedAPI)
    }

    override func tearDownWithError() throws {
        bag = nil
        mockedAPI = nil
        sut = nil
    }

    func testFetchSuccess() {
        let responseSubject = PublishSubject<CarModelResponse>()
        mockedAPI.given(.fetchCarModels(page: .any, manufacturerID: .any, willReturn: responseSubject))
        
        let exp = expectation(description: "Fetch Models Success")
        sut.allModels.subscribe(onNext: { [weak self] models in
            guard let weakSelf = self else { return }
            if models.count > 0 && !weakSelf.sut.shouldFetchMore {
                exp.fulfill()
            }
        }).disposed(by: bag)
        sut.fetchCarModels(manufacturerID: "103")
        
        let car1 = CarModel(name: "Continental GT")
        let car2 = CarModel(name: "Continental SC")
        let response = CarModelResponse(page: 0, totalPageCount: 1, models: [car1, car2])
        responseSubject.onNext(response)
        waitForExpectations(timeout: 10) {
            if $0 != nil { XCTFail("Expectation not fulfilled") }
        }
    }
    
    func testFetchError() {
        let responseSubject = PublishSubject<CarModelResponse>()
        mockedAPI.given(.fetchCarModels(page: .any, manufacturerID: .any, willReturn: responseSubject))
        
        let exp = expectation(description: "Fetch Models Eror")
        sut.errorObservable.subscribe(onNext: { errorMsg in
            if !errorMsg.isEmpty {
                exp.fulfill()
            }
        }).disposed(by: bag)
        sut.fetchCarModels(manufacturerID: "103")
        
        responseSubject.onError(HTTPNetworkError.noInternetConnection)
        waitForExpectations(timeout: 10) {
            if $0 != nil { XCTFail("Expectation not fulfilled") }
        }
    }
}
