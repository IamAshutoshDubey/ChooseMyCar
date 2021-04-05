//
//  CarModelsViewModel.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation
import RxSwift

class CarModelsViewModel {
    
    private var page: Int = 0
    private (set) var shouldFetchMore: Bool = true
    private let bag = DisposeBag()
    
    let isLoading = PublishSubject<Bool>()
    private let modelsSubject = PublishSubject<[CarModel]>()
    var modelsObservable: Observable<[CarModel]> {modelsSubject.asObservable()}
    
    private let errorSubject = PublishSubject<String>()
    var errorObservable: Observable<String> {errorSubject.asObservable()}

    private var totalPages: Int = 0
    private let api: CarAPIType
    
    init(api: CarAPIType) {
        self.api = api
    }
    
    func fetchCarModels(manufacturerID: String) {
        if shouldFetchMore {
            isLoading.onNext(true)
            api.fetchCarModels(page: page, manufacturerID: manufacturerID)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] (response) in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading.onNext(false)
                    weakSelf.modelsSubject.onNext(response.models)
                    weakSelf.totalPages = response.totalPageCount
                    weakSelf.page += weakSelf.page
                    weakSelf.shouldFetchMore = weakSelf.totalPages > (weakSelf.page + 1)
                }, onError: { [weak self] (error) in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading.onNext(false)
                    let description = (error as? HTTPNetworkError)?.errorMessage ?? error.localizedDescription
                    weakSelf.errorSubject.onNext(description)
                }).disposed(by: bag)
        }
    }
}
