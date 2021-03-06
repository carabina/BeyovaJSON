//
//  BeyovaJSONTests.swift
//  BeyovaJSONTests
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import XCTest
@testable import BeyovaJSON

class User: Codable {
    var AnyThing: JToken = .null
}

class BeyovaJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCompare() {
        let x = JToken.init(2 as Int)
        let y = JToken.init(1 as Int8)
        XCTAssertTrue(x >= y)
    }
    
    func testNil() {
        var obj: JToken = ["key1": 1, "key2": [:]]
        _ = obj["key3"]["key"]
    }
    
    func testConvertable() {
        let val = Decimal(1.1) as JConvertable
        let r:Int8 = val.convert()
        XCTAssertEqual(r, 1)
    }
    
    func testSimple() {
        let val: JToken = "string1"
        print(val)
    }
    
    func testInt() {
        let val: JToken = 111111
        XCTAssertTrue(val.intValue == 111111)
    }
    
    func testAppend() {
        var array: JToken = []
        array.append(1.1)
        array.append("test")
        print(array)
    }
    
    func testSetValue() {
        var dict: JToken = [:]
        dict["key1"] = 1.1
        let val = dict["key1"]
        XCTAssertNotNil(val)
        XCTAssertEqual(1, val.int)
    }
    
    func testJObjectIteration() {
        let dict: JToken = ["key1": 1.1,"key2": "value2"]
        for item in dict {
            print("key = \(item.key) value = \(item.value)")
        }
        print(dict)
    }
    
    func testJArrayIteration() {
        let array: JToken = [1.1,"test"]
        for item in array {
            print(item.key)
            print(item.value)
        }
    }
    
    func testRaw() throws {
//        JToken.encoder.dateEncodingStrategy = .iso8601
//        JToken.decoder.dateDecodingStrategy = .iso8601
        let token: JToken = ["dateTest":Date(),"key1":1.1,"key2":["sub",1,["subsub"]]]
        let data = try token.rawData(formatting: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)
    }
    
    func testCoding() {
        let user = User()
        user.AnyThing = ["dateTest":Date(),"key1":1.1,"key2":["sub",1,["subsub"]]]
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(user)
        let s = String(bytes: data, encoding: .utf8)!
        print(s)
        
        let decoder = JSONDecoder()
        let user2 = try! decoder.decode(User.self, from: data)
        print(user2.AnyThing)
    }
}
