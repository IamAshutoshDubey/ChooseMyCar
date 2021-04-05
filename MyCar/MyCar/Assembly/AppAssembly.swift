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
        container.register(NetworkClientType.self) { (resolver) in
            let baseUrl = NetworkConstants.baseURL
            let headers = [NetworkConstants.appIDKey: NetworkConstants.appID]
            return NetworkClient(baseUrl: baseUrl, headers: headers)
        }

    }
}
