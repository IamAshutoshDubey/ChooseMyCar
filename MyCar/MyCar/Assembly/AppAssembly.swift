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

        container.register(ManufacturersViewModel.self) { (resolver) in
            return ManufacturersViewModel(api: resolver.resolve(CarAPIType.self)!)
        }
        
        container.register(AppRouterType.self) { (resolver) in
            return AppRouter(resolver: resolver)
        }

    }
}
