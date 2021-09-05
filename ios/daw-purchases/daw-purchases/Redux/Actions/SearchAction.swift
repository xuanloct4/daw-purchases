//
//  SearchAction.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwift
import Moya
import RxSwift
import Result
import ObjectMapper
    
struct SearchUserPurchaseProduct: Action {}

struct SearchUserPurchaseProductAction: Action {
    let username: String
    let results: Result<[Product], APIError>
}

struct ResetSearchAction: Action {}

struct SearchAction {
    public static func searchUsersPurchaseProduct(username: String, limit:Int?) -> SearchUserPurchaseProduct {
        NetworkService.rxRequestCallback(api: .getPurchasesByUser(username: username, limit: limit), onSuccess: { (purchases: Purchases?) in
            
            _ = listUserPurchaseProduct(username: username, purchases: purchases?.purchases ?? [])
        }, onError: { error in
            store.dispatch(SearchUserPurchaseProductAction(username: username, results: .failure(.somethingWentWrong(error.localizedDescription))))
        })
        
        return SearchUserPurchaseProduct()
    }
    
    public static func listProduct(purchases: [Purchase]) -> [Int] {
        let productIds:[Int] = purchases.map { purchase in
                   return purchase.productId
               }.unique()
        return productIds
    }
    
    public static func listUserPurchaseProduct(username: String, purchases: [Purchase]) -> SearchUserPurchaseProduct {
        let productIds = listProduct(purchases: purchases)
        var productInfo = [Product]()
        let productIdsObservable = Observable.of(productIds)
        
        if(productIds.count == 0) {
            store.dispatch(SearchUserPurchaseProductAction(username: username, results: .success([])))
            return SearchUserPurchaseProduct()
        }
        
        let productObservables: [Observable<(Purchases?, Product?)>] = productIds.map { productId in
            let _purchasesObserver: Observable<Purchases?>  = NetworkService.rxRequest(api: DAWProvider.getPurchasesByProductId(productId: productId, limit: nil))
            let _productInfoObserver: Observable<Product?> = NetworkService.rxRequest(api: DAWProvider.getProductById(productId: productId))
            
            let observable = Observable
                .zip(_purchasesObserver, _productInfoObserver)
            return observable
        }
        
        let productInfoObservables = Observable.merge(productObservables).asObservable()
        productInfoObservables.subscribe(onNext: { purchases, product in
            if let product = product {
                product.product?.recent.removeAll()
                _ = purchases?.purchases.map { p in
                    product.product?.recent.append(p.username)
                }
                productInfo.append(product)
            }
        }).disposed(by: NetworkService.disposeBag)
        
        _ = Observable.zip(productIdsObservable,productInfoObservables).bind(onNext: { _,_ in
            productInfo.sort { a,b in
                let recentA = a.product?.recent ?? []
                let recentB = b.product?.recent ?? []

                return recentA.count > recentB.count
            }
            store.dispatch(SearchUserPurchaseProductAction(username: username, results: .success(productInfo)))
        })
        
        return SearchUserPurchaseProduct()
    }
}
