//
//  NetworkClient.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation
import RxSwift

protocol NetworkClientType {
    func getRequest<ResponseType: Decodable>(path: String, urlParameters: [String: String]) -> PublishSubject<ResponseType>
}

class NetworkClient: NSObject, NetworkClientType {
    var task: URLSessionTask?
    let baseUrl: String
    var headers: [String: String] = [:]
    var session: URLSession?
    
    public init(baseUrl: String, headers: [String: String] = [:]) {
        self.baseUrl = baseUrl
        self.headers = headers
    }
    
    func getRequest<ResponseType>(path: String, urlParameters: [String : String]) -> PublishSubject<ResponseType> where ResponseType : Decodable {
        
        let request = buildGetRequest(path: path, urlParameters)
        
        if session == nil {
            session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        }
        
        let responseSubject = PublishSubject<ResponseType>()
        print(request)
        task = session!.dataTask(with: request, completionHandler: { data, response, error in
            if error != nil {
                if let noInternetError = error as NSError?,
                   noInternetError.code == NSURLErrorNotConnectedToInternet,
                   noInternetError.domain == NSURLErrorDomain {
                    responseSubject.onError(HTTPNetworkError.noInternetConnection)
                    return
                }
                responseSubject.onError(HTTPNetworkError.other)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                    case 200...299:
                        guard let responseData = data else {
                            responseSubject.onError(HTTPNetworkError.other)
                            return
                        }
                        do {
                            let apiResponse = try JSONDecoder().decode(ResponseType.self, from: responseData)
                            print(apiResponse)
                            responseSubject.onNext(apiResponse)
                        } catch {
                            print(error)
                            responseSubject.onError(HTTPNetworkError.unableToDecode)
                        }
                    default:
                        responseSubject.onError(HTTPNetworkError.other)
                }
            }
        })
        self.task?.resume()
        return responseSubject
    }
    
    private func buildGetRequest(path: String, _ parameters: [String : String]) -> URLRequest {
        let url = URL(string: self.baseUrl)!.appendingPathComponent(path)
        var urlParameters:  [String : String] = parameters
        for headerKey in headers.keys {
            urlParameters[headerKey] = headers[headerKey]
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = urlParameters.map {key, value in
            URLQueryItem(name: key,
                         value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        }
        var request = URLRequest(url: (urlComponents?.url!)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = "GET"
        return request
    }
}
