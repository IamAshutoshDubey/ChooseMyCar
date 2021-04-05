//
//  ResponseDecoder.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation

//sourcery: AutoMockable
protocol ResponseDecoderType {
    func decode<ResponseType: Decodable>(responseData: Data) throws -> ResponseType
}

struct ResponseDecoder: ResponseDecoderType  {
    func decode<ResponseType>(responseData: Data) throws -> ResponseType where ResponseType : Decodable {
        try JSONDecoder().decode(ResponseType.self, from: responseData)
    }
}
