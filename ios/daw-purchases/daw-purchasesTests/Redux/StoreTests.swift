//
//  StoreTests.swift
//  daw-purchasesTests
//
//  Created by Tran Loc on 11/1/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import XCTest
import RxSwift
import ReSwift
import RxTest

class DispatchingTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    struct NullReducer: ReSwift.Reducer<ReducerStateType> {
//        func handleAction(action: Action, state: AppState?) -> AppState {
//            return AppState(value: -1)
//        }
//    }

//    func testDispatchesValueChanges() {
//
//        // Set up a signal. Subscription per default starts at time=200
//        let scheduler = TestScheduler(initialClock: 0)
//        let signal = scheduler.createHotObservable([
//            next(300, 98),
//            next(600, 12)
//            ])
//
//        // Set up the store and record matching actions.
//        let storeDouble = Store(reducer: NullReducer(), state: nil)
//        var actions = [Recorded<Event<ChangingCount>>]()
//        storeDouble.dispatchFunction = {
//            guard let action = $0 as? ChangingCount else { return () }
//            // `return f()` where `f() -> Void` is just like `return ()`.
//            // We need to return something to satisy the `-> Any`.
//            return actions.append(Recorded(time: scheduler.clock, value: .next(action)))
//        }
//
//        // Configure the object under test and start emitting
//        // values in virtual time.
//        let dispatcher = ReSwift.Dispatcher(store: storeDouble)
//        dispatcher.wireSignalToAction(signal)
//        scheduler.start()
//
//        XCTAssertEqual(actions, [
//            next(300, ChangingCount(value: 98)),
//            next(600, ChangingCount(value: 12))
//            ])
//    }
}
