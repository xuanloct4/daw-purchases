//
//  SearchReducer.swift
//  daw-purchasesTests
//
//  Created by Tran Loc on 11/1/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import daw_purchases

class SearchReducerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchReducer_SearchUserPurchaseProductAction() {
        let newProductJSON: [String: [String:Any]] = ["product":["id":111111,"face":"(✿◖◡◗)","price":100,"size":11]]
        let newProduct = Mapper<Product>().map(JSON: newProductJSON)!
        
        let oldProductJSON: [String: [String:Any]] = ["product":["id":222222,"face":"(✿◖◡◗)","price":200,"size":22]]
        let oldProduct = Mapper<Product>().map(JSON: oldProductJSON)!
        
        
        let action = SearchUserPurchaseProductAction(username: "abc", results: .success([newProduct]))
        let state = SearchState(username: "xyz", productResults: .success([oldProduct]), limit: 5)
        
        let newState = searchReducer(action: action, state: state)
        
        XCTAssertEqual(newState.username, action.username)
        XCTAssertEqual(try action.results.get().count, try newState.productResults?.get().count)
        XCTAssertEqual(try action.results.get().count, 1)
        XCTAssertEqual(try action.results.get()[0].product?.id ?? -1, try newState.productResults?.get()[0].product?.id ?? 0)
    }
    
    func testSearchReducer_ResetSearchAction() {
        let oldProductJSON: [String: [String:Any]] = ["product":["id":222222,"face":"(✿◖◡◗)","price":200,"size":22]]
        let oldProduct = Mapper<Product>().map(JSON: oldProductJSON)!
        
        let action = ResetSearchAction()
        let state = SearchState(username: "xyz", productResults: .success([oldProduct]), limit: 5)
        
        let newState = searchReducer(action: action, state: state)
        
        XCTAssertNil(newState.username)
        XCTAssertNil(try newState.productResults?.get())
    }
    
    func testSearchReducer_OtherAction() {
        let oldProductJSON: [String: [String:Any]] = ["product":["id":222222,"face":"(✿◖◡◗)","price":200,"size":22]]
        let oldProduct = Mapper<Product>().map(JSON: oldProductJSON)!
        
        let action = SearchUserPurchaseProduct()
        let state = SearchState(username: "xyz", productResults: .success([oldProduct]), limit: 5)
        
        let newState = searchReducer(action: action, state: state)
        
        XCTAssertEqual(newState.username, state.username)
        XCTAssertEqual(try state.productResults?.get().count, try newState.productResults?.get().count)
        XCTAssertEqual(try state.productResults?.get().count, 1)
        XCTAssertEqual(try state.productResults?.get()[0].product?.id ?? -1, try newState.productResults?.get()[0].product?.id ?? 0)
    }
}
