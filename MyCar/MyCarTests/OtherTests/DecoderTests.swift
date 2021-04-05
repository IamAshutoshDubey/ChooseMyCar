//
//  DecoderTests.swift
//  MyCarTests
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import XCTest
@testable import MyCar


class DecoderTests: XCTestCase {

    var responseDecoder: ResponseDecoder!
    
    override func setUpWithError() throws {
        responseDecoder = ResponseDecoder()
    }

    override func tearDownWithError() throws {
        responseDecoder = nil
    }

    func testManufacturerResponseDecoder() {
        let responseStr = #"{"page":0,"pageSize":15,"totalPageCount":6,"wkda":{"107":"Bentley","125":"Borgward","130":"BMW","141":"Buick","145":"Brilliance","150":"Cadillac","157":"Caterham","160":"Chevrolet","020":"Abarth","040":"Alfa Romeo","042":"Alpina","043":"Alpine","057":"Aston Martin","060":"Audi","095":"Barkas"}}"#
        
        let responseData =  Data(responseStr.utf8)
        
        let responseObject: ManufacturerResponse? = try? responseDecoder.decode(responseData: responseData)
        XCTAssertNotNil(responseObject)
        XCTAssertEqual(responseObject?.totalPageCount, 6)
        XCTAssertEqual(responseObject?.manufactures.count, 15)
    }
    
    func testModelResponseDecoder() {
        let responseStr = #"{"page":0,"pageSize":10,"totalPageCount":1,"wkda":{"Arnage":"Arnage","Azure":"Azure","Continental Flying Spur":"Continental Flying Spur","Continental GT":"Continental GT","Continental GTC":"Continental GTC","Continental SC":"Continental SC"}}"#
        
        let responseData =  Data(responseStr.utf8)
        
        let responseObject: CarModelResponse? = try? responseDecoder.decode(responseData: responseData)
        XCTAssertNotNil(responseObject)
        XCTAssertEqual(responseObject?.totalPageCount, 1)
        XCTAssertEqual(responseObject?.models.count, 6)
    }
    
    func testDecodeFailure() {
        let responseStr = #"["page":0,"pageSize":10,"totalPageCount":1,"wkda":{"Arnage":"Arnage","Azure":"Azure","Continental Flying Spur":"Continental Flying Spur","Continental GT":"Continental GT","Continental GTC":"Continental GTC","Continental SC":"Continental SC"}]"#
        
        let responseData =  Data(responseStr.utf8)
        let responseObject: ManufacturerResponse? = try? responseDecoder.decode(responseData: responseData)
        XCTAssertNil(responseObject)
    }
}
