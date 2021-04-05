//
//  ManufacturerResponse.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation

struct ManufacturerResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPageCount = "totalPageCount"
        case manufactures = "wkda"
    }
    
    var page: Int
    var totalPageCount: Int
    var manufactures: [Manufacture]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try! container.decode(Int.self, forKey: .page)
        totalPageCount = try! container.decode(Int.self, forKey: .totalPageCount)
        let manufactureMap = try! container.decode([String : String].self, forKey: .manufactures)
        var tempManufactures = [Manufacture]()
        for key in manufactureMap.keys {
            if let name = manufactureMap[key] {
                let manufacture =  Manufacture(name: name, id: key)
                tempManufactures.append(manufacture)
            }
        }
        manufactures = tempManufactures
    }
    
    init(page: Int, totalPageCount: Int, manufactures: [Manufacture]) {
        self.page = page
        self.totalPageCount = totalPageCount
        self.manufactures = manufactures
    }
}


struct Manufacture {
    var name: String
    var id: String
}
