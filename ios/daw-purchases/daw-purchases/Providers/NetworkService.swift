//
//  NetworkService.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/31/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

class NetworkService: NSObject {
    public static func rxRequestCallback<T: Mappable>(api: DAWProvider, onSuccess: ((T?)->())? = nil, onError: ((Error)->())? = nil, onCompleted: (()->())? = nil) {
        let observable: Observable<T?>  = NetworkService.rxRequest(api: api)
        observable.subscribe(onNext: { data in
            onSuccess?(data)
        }, onError: { error in
            onError?(error)
        }, onCompleted: onCompleted, onDisposed: nil).disposed(by: SearchState.disposeBag)
    }
    
    
    public static func rxRequestCallback<T: Mappable, P: TargetType>(moyaProvider: MoyaProvider<P>, api: P, onSuccess: ((T?)->())? = nil, onError: ((Error)->())? = nil, onCompleted: (()->())? = nil, disposeBag: DisposeBag) {
        
        let observable: Observable<T?>  = NetworkService.rxRequest(moyaProvider: moyaProvider, api: api)
        observable.subscribe(onNext: { data in
            onSuccess?(data)
        }, onError: { error in
            onError?(error)
        }, onCompleted: onCompleted, onDisposed: nil).disposed(by: disposeBag)
    }
    
    public static func rxRequest<T: Mappable>(api: DAWProvider) -> Observable<T?> {
        return NetworkService.rxRequest(moyaProvider: SearchState.moyaProvider, api: api)
    }
    
    
    public static func rxRequest<T: Mappable, P: TargetType>(moyaProvider: MoyaProvider<P>, api: P) -> Observable<T?> {
        return Observable.create ({ (observer) -> Disposable in
            _ = moyaProvider.rx.request(api).subscribe { event in
                switch event {
                case .success(let response):
                    do {
                        if let json = try response.mapJSON() as? [String:Any] {
                            let responseMap = Mapper<T>().map(JSON: json)
                            observer.onNext(responseMap)
                        }
                    } catch {
                        let printableError = error as CustomStringConvertible
                        let errorMessage = printableError.description
                        print(errorMessage)
                        observer.onError(error)
                    }
                    print (response)
                    break
                case .error(let error):
                    print (error)
                    observer.onError(error)
                    break
                }
            }
            return Disposables.create()
        })
    }
}
