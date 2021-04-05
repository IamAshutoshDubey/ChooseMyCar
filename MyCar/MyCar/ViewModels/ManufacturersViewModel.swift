//
//  ManufacturersViewModel.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation
import RxSwift
import RxRelay

class ManufacturersViewModel {
    
    private var page: Int = 0
    private var totalPages: Int = 0
    var noMoreFetch = BehaviorRelay<Bool>(value: false)
    private let bag = DisposeBag()
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    var manufacturers = BehaviorRelay<[Manufacture]>(value: [])
    private var manufacturersAll = [Manufacture]()
    
    private let errorSubject = PublishSubject<String>()
    var errorObservable: Observable<String> {errorSubject.asObservable()}

    
    private let api: CarAPIType
    private let router: AppRouterType
    
    init(api: CarAPIType, router: AppRouterType) {
        self.api = api
        self.router = router
    }
    
    func fetchManufacturers() {
        if !noMoreFetch.value {
            isLoading.accept(true)
            api.fetchManufacturers(page: page)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] (response) in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading.accept(false)
                    weakSelf.totalPages = response.totalPageCount
                    weakSelf.page += 1
                    weakSelf.noMoreFetch.accept(weakSelf.totalPages <= (weakSelf.page + 1))
                    weakSelf.manufacturersAll.append(contentsOf: response.manufactures)
                    weakSelf.manufacturers.accept( weakSelf.manufacturersAll)
                }, onError: { [weak self] (error) in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading.accept(false)
                    let description = (error as? HTTPNetworkError)?.errorMessage ?? error.localizedDescription
                    weakSelf.errorSubject.onNext(description)
                }).disposed(by: bag)
        }
    }
    
    func manufacturerSelected(source: ViewControllerType, manufacture: Manufacture) {
        router.navigateToCarModels(source: source, manufacture)
    }
    
    
}
