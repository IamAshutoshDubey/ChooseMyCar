//
//  AppAssembly.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation
import Swinject

class AppAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ResponseDecoderType.self) { (resolver) in
            return ResponseDecoder()
        }
        
        container.register(NetworkClientType.self) { (resolver) in
            let baseUrl = NetworkConstants.baseURL
            let headers = [NetworkConstants.appIDKey: NetworkConstants.appID]
            let decoder = resolver.resolve(ResponseDecoderType.self)!
            return NetworkClient(baseUrl: baseUrl, headers: headers, responseDecoder: decoder)
        }
        
        container.register(CarAPIType.self) { (resolver) in
            return CarAPI(networkClient: resolver.resolve(NetworkClientType.self)!)
        }
        
        container.register(AppRouterType.self) { (resolver) in
            return AppRouter(resolver: resolver)
        }
        
        container.register(ManufacturersViewModel.self) { (resolver) in
            let api = resolver.resolve(CarAPIType.self)!
            let router = resolver.resolve(AppRouterType.self)!
            return ManufacturersViewModel(api: api, router: router)
        }
        
        container.register(CarModelsViewModel.self) { (resolver) in
            return CarModelsViewModel(api: resolver.resolve(CarAPIType.self)!)
        }
       

    }
}
