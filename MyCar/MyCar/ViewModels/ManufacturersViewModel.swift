//
//  ManufacturersViewModel.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation
import RxSwift

class ManufacturersViewModel {
    
    private var page: Int = 0
    private var shouldFetchMore: Bool = true
    private let bag = DisposeBag()
    
    let isLoading = PublishSubject<Bool>()
    private let manufacturersSubject = PublishSubject<[Manufacture]>()
    var manufacturersObservable: Observable<[Manufacture]> {manufacturersSubject.asObservable()}
    
    private let errorSubject = PublishSubject<String>()
    var errorObservable: Observable<String> {errorSubject.asObservable()}

    
    private var totalPages: Int = 0
    private let api: CarAPIType
    
    init(api: CarAPIType) {
        self.api = api
    }
    
    func fetchManufacturers() {
        if shouldFetchMore {
            isLoading.onNext(true)
            api.fetchManufacturers(page: page)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] (response) in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading.onNext(false)
                    weakSelf.manufacturersSubject.onNext( response.manufactures)
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
    
    func manufacturerSelected(manufacture: Manufacture) {
        
    }
    
    
}
