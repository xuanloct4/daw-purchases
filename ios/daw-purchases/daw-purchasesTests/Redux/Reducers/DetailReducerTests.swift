//
//  DetailReducer.swift
//  daw-purchasesTests
//
//  Created by Tran Loc on 11/1/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import daw_purchases

class DetailReducerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetailReducer_DetailAction() {
        let newProductJSON: [String: [String:Any]] = ["product":["id":111111,"face":"(✿◖◡◗)","price":100,"size":11]]
        let newProduct = Mapper<Product>().map(JSON: newProductJSON)!
        
        let oldProductJSON: [String: [String:Any]] = ["product":["id":222222,"face":"(✿◖◡◗)","price":200,"size":22]]
        let oldProduct = Mapper<Product>().map(JSON: oldProductJSON)!
        
        
        let action = DetailAction(product: newProduct)
        let state = DetailState(product: oldProduct)
        
        let newState = detailReducer(action: action, state: state)
        
        XCTAssertEqual(action.product?.product?.id ?? -1, newState.product?.product?.id ?? 0)
    }
    
    
    func testDetailReducer_OtherAction() {
        let oldProductJSON: [String: [String:Any]] = ["product":["id":222222,"face":"(✿◖◡◗)","price":200,"size":22]]
        let oldProduct = Mapper<Product>().map(JSON: oldProductJSON)!
        
        let action = SearchUserPurchaseProduct()
        let state = DetailState(product: oldProduct)
        
        let newState = detailReducer(action: action, state: state)
        
        XCTAssertEqual(state.product?.product?.id ?? -1, newState.product?.product?.id ?? 0)
    }
    
}
