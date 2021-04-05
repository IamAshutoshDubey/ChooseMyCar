//
//  CarAPI.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation
import RxSwift


protocol CarAPIType {
    var networkClient: NetworkClientType { get }
    func fetchManufacturers(page: Int) -> PublishSubject<ManufacturerResponse>
    func fetchCarModels(page: Int, manufacturerID: String) -> PublishSubject<CarModelResponse>
}

class CarAPI: CarAPIType {
    let networkClient: NetworkClientType

    init(networkClient: NetworkClientType) {
        self.networkClient = networkClient
    }
    
    func fetchManufacturers(page: Int) -> PublishSubject<ManufacturerResponse> {
        networkClient.getRequest(path: "v1/car-types/manufacturer", urlParameters: ["page": "\(page)", "pageSize": "\(10)"])
    }
    
    func fetchCarModels(page: Int, manufacturerID: String) -> PublishSubject<CarModelResponse> {
        networkClient.getRequest(path: "v1/car-types/main-types", urlParameters: ["page": "\(page)", "pageSize": "\(10)", "manufacturer": manufacturerID])
    }

}
