//
//  CarModelResponse.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation

struct CarModelResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPageCount = "totalPageCount"
        case models = "wkda"
    }
    
    var page: Int
    var totalPageCount: Int
    var models: [CarModel]
    
    private struct DynamicCodingKeys: CodingKey {

            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }

            var intValue: Int?
            init?(intValue: Int) {
                return nil
            }
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try! container.decode(Int.self, forKey: .page)
        totalPageCount = try! container.decode(Int.self, forKey: .totalPageCount)
        let modelMap = try! container.decode([String : String].self, forKey: .models)
        var tempModels = [CarModel]()
        for key in modelMap.keys {
            if let name = modelMap[key] {
                let model =  CarModel(name: name)
                tempModels.append(model)
            }
        }
        models = tempModels
    }
    
    init(page: Int, totalPageCount: Int, models: [CarModel]) {
        self.page = page
        self.totalPageCount = totalPageCount
        self.models = models
    }
}

struct CarModel {
    var name: String
}
