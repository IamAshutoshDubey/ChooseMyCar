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
    var session: URLSession?
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getRequest<ResponseType>(path: String, urlParameters: [String : String]) -> PublishSubject<ResponseType> where ResponseType : Decodable {
        
        let url = URL(string: self.baseUrl)!.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = urlParameters.map {key, value in
            URLQueryItem(name: key,
                         value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        }
        var request = URLRequest(url: (urlComponents?.url!)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = "GET"
        
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
                    print(error)
                    return
                }
                responseSubject.onError(HTTPNetworkError.other)
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(data)
                switch response.statusCode {
                    case 200...299:
                        guard let responseData = data else {
                            responseSubject.onError(HTTPNetworkError.other)
                            return
                        }
                        do {
                            let apiResponse = try JSONDecoder().decode(ResponseType.self, from: responseData)
                            responseSubject.onNext(apiResponse)
                        } catch {
                            print(error)
                            responseSubject.onError(HTTPNetworkError.unableToDecode)
                        }
                    default:
                        print(error)
                        responseSubject.onError(HTTPNetworkError.other)
                }
            }
        })
        self.task?.resume()
        return responseSubject
    }
}
