//
//  StoreTests.swift
//  daw-purchasesTests
//
//  Created by Tran Loc on 11/1/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import XCTest
import ReSwift
import ObjectMapper
@testable import daw_purchases

class DefaultStoreRecording {
    init(store: Store<AppState> = nullDefaultStore()) {
        self.store = store
        let originalDispatch = self.store.dispatchFunction
        self.store.dispatchFunction = { action in
            self.actions.append(action)
            originalDispatch?(action)
        }
    }
    
    let store: Store<AppState>
    var actions = [Action]()
    var firstAction: Action? { return actions.first }
    var didRecordAction: Bool { return !actions.isEmpty }
    
    func reset() {
        actions = []
    }
}

func nullDefaultStore() -> Store<AppState> {
    return Store<AppState>(
        reducer: appReducer,
        state: nil,
        middleware: [])
}

class ProductSubscriber: StoreSubscriber {
    var username: String?
    var productResults: Result<[Product], APIError>?
    func newState(state: SearchState) {
        self.username = state.username
        self.productResults = state.productResults
    }
}

class StoreTests: XCTestCase {
    let storeRecording = DefaultStoreRecording()
    let productSubscriber = ProductSubscriber()
    override func setUpWithError() throws {
        self.storeRecording.store.subscribe(productSubscriber) {
            $0.select {
                $0.searchState
            }
        }
    }
    
    override func tearDownWithError() throws {
        store.unsubscribe(productSubscriber)
    }
    
    
    func testStore_DispatchAction() {
        let storeRecording = DefaultStoreRecording()
        
        let newProductJSON: [String: [String:Any]] = ["product":["id":111111,"face":"(✿◖◡◗)","price":100,"size":11]]
        let newProduct = Mapper<Product>().map(JSON: newProductJSON)!
        
        let action = SearchUserPurchaseProductAction.init(username: "abc", results: .success([newProduct]))
        storeRecording.store.dispatch(action)
        
        XCTAssertEqual(storeRecording.actions.count, 1)
        XCTAssertTrue(storeRecording.didRecordAction)
        
        let first = storeRecording.actions.first as? SearchUserPurchaseProductAction
        XCTAssertEqual(first?.username , action.username)
        XCTAssertEqual(try first?.results.get().count, try action.results.get().count)
        XCTAssertEqual(try first?.results.get()[0].product?.id ?? 0, newProduct.product?.id ?? -1)
    }
    
    func testStore_StoreSubscriber() {
        let newProductJSON: [String: [String:Any]] = ["product":["id":111111,"face":"(✿◖◡◗)","price":100,"size":11]]
        let newProduct = Mapper<Product>().map(JSON: newProductJSON)!
        let action = SearchUserPurchaseProductAction.init(username: "abc", results: .success([newProduct]))
        storeRecording.store.dispatch(action)
        
        XCTAssertEqual(storeRecording.actions.count, 1)
        XCTAssertTrue(storeRecording.didRecordAction)
        XCTAssertEqual(productSubscriber.username, action.username)
        XCTAssertEqual(try productSubscriber.productResults?.get().count, try action.results.get().count)
        XCTAssertEqual(try productSubscriber.productResults?.get()[0].product?.id ?? 0, newProduct.product?.id ?? -1)
    }
}
