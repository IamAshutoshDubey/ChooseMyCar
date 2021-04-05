//
//  CarModelsViewModel.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation
import RxSwift
import RxRelay

class CarModelsViewModel {
    
    private var page: Int = 0
    private var totalPages: Int = 0
    private (set) var shouldFetchMore: Bool = true
    private let bag = DisposeBag()
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    var allModels = BehaviorRelay<[CarModel]>(value: [])
    private var _allModels = [CarModel]()
    
    private let errorSubject = PublishSubject<String>()
    var errorObservable: Observable<String> {errorSubject.asObservable()}

    private let api: CarAPIType
    
    init(api: CarAPIType) {
        self.api = api
    }
    
    func fetchCarModels(manufacturerID: String) {
        if shouldFetchMore {
            isLoading.accept(true)
            api.fetchCarModels(page: page, manufacturerID: manufacturerID)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] (response) in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading.accept(false)
                    weakSelf.totalPages = response.totalPageCount
                    weakSelf.page += 1
                    weakSelf.shouldFetchMore = weakSelf.totalPages > (weakSelf.page + 1)
                    weakSelf._allModels.append(contentsOf: response.models)
                    weakSelf.allModels.accept(weakSelf._allModels)
                }, onError: { [weak self] (error) in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading.accept(false)
                    let description = (error as? HTTPNetworkError)?.errorMessage ?? error.localizedDescription
                    weakSelf.errorSubject.onNext(description)
                }).disposed(by: bag)
        }
    }
}
