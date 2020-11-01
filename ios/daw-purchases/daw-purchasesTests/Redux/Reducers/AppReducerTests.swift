//
//  AppReducer.swift
//  daw-purchasesTests
//
//  Created by Tran Loc on 11/1/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import daw_purchases

class AppReducerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppReducer_DetailAction() {
        let newProductJSON: [String: [String:Any]] = ["product":["id":111111,"face":"(✿◖◡◗)","price":100,"size":11]]
        let newProduct = Mapper<Product>().map(JSON: newProductJSON)!
        
        let action = DetailAction(product: newProduct)
        let newState = appReducer(action: action, state: nil)
        
        
        XCTAssertEqual(newState.navigationState.route.count, 0)
        XCTAssertNil(newState.searchState.username)
        XCTAssertNil(newState.searchState.productResults?.value)
        XCTAssertNil(newState.searchState.limit)
        XCTAssertEqual(newState.detailState.product?.product?.id ?? -1, newProduct.product?.id ?? 0)
    }
    
    func testAppReducer_SearchAction() {
        let newProductJSON: [String: [String:Any]] = ["product":["id":111111,"face":"(✿◖◡◗)","price":100,"size":11]]
        let newProduct = Mapper<Product>().map(JSON: newProductJSON)!
        
        let action = SearchUserPurchaseProductAction(username: "abc", results: .success([newProduct]))
        let newState = appReducer(action: action, state: nil)
        
        XCTAssertEqual(newState.navigationState.route.count, 0)
        XCTAssertEqual(newState.searchState.username, action.username)
        XCTAssertEqual(try action.results.get().count, try newState.searchState.productResults?.get().count)
        XCTAssertEqual(try action.results.get().count, 1)
        XCTAssertEqual(try action.results.get()[0].product?.id ?? -1, try newState.searchState.productResults?.get()[0].product?.id ?? 0)
        XCTAssertNil(newState.detailState.product)
    }
    
    
    func testAppReducer_ResetAction() {
        let newProductJSON: [String: [String:Any]] = ["product":["id":111111,"face":"(✿◖◡◗)","price":100,"size":11]]
        let newProduct = Mapper<Product>().map(JSON: newProductJSON)!
        
        let searchAction = SearchUserPurchaseProductAction(username: "abc", results: .success([newProduct]))
        let detailAction = DetailAction(product: newProduct)
        let resetAction = ResetSearchAction()
        let newStateFromSearchAction = appReducer(action: searchAction, state: nil)
        let newStateFromDetailAction = appReducer(action: detailAction, state: newStateFromSearchAction)
        
        XCTAssertEqual(newStateFromDetailAction.navigationState.route.count, 0)
        XCTAssertEqual(newStateFromDetailAction.searchState.username, searchAction.username)
        XCTAssertEqual(try searchAction.results.get().count, try newStateFromDetailAction.searchState.productResults?.get().count)
        XCTAssertEqual(try searchAction.results.get().count, 1)
        XCTAssertEqual(try searchAction.results.get()[0].product?.id ?? -1, try newStateFromDetailAction.searchState.productResults?.get()[0].product?.id ?? 0)
        XCTAssertEqual(newStateFromDetailAction.detailState.product?.product?.id ?? -1, newProduct.product?.id ?? 0)
        
        let newStateFromResetAction = appReducer(action: resetAction, state: newStateFromDetailAction)
        XCTAssertEqual(newStateFromResetAction.navigationState.route.count, 0)
        XCTAssertNil(newStateFromResetAction.searchState.username)
        XCTAssertNil(newStateFromResetAction.searchState.productResults?.value)
        XCTAssertNil(newStateFromResetAction.searchState.limit)
        XCTAssertEqual(newStateFromResetAction.detailState.product?.product?.id ?? -1, newProduct.product?.id ?? 0)
    }
}
