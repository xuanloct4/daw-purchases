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

extension SearchState {
    public static func searchUsersPurchaseProduct(username: String, limit:Int?) -> SearchUserPurchaseProduct {
        NetworkService.rxRequestCallback(api: .getPurchasesByUser(username: username, limit: limit), onSuccess: { (purchases: Purchases?) in
            
            listUserPurchaseProduct(username: username, purchases: purchases?.purchases ?? [])
        }, onError: { error in
            store.dispatch(SearchUserPurchaseProductAction(username: username, results: .failure(.somethingWentWrong(error.localizedDescription))))
        })
        
        return SearchUserPurchaseProduct()
    }
    
    public static func listUserPurchaseProduct(username: String, purchases: [Purchase]) -> SearchUserPurchaseProduct {
        let productIds:[Int] = purchases.map { purchase in
            return purchase.productId
        }.unique()
        
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
        
        var productInfo = [Product]()
        
        let productIdsObservable = Observable.of(productIds)
        let productInfoObservables = Observable.merge(productObservables).asObservable()
        productInfoObservables.bind(onNext: { purchases, product in
            if let product = product {
                product.product?.recent.removeAll()
                _ = purchases?.purchases.map { p in
                    product.product?.recent.append(p.username)
                }
                productInfo.append(product)
            }
        }).disposed(by: SearchState.disposeBag)
        
        _ = Observable.zip(productIdsObservable,productInfoObservables).subscribe(onNext: { _,_ in
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
    
struct SearchUserPurchaseProduct: Action {}

struct SearchUserPurchaseProductAction: Action {
    let username: String
    let results: Result<[Product], APIError>
}

struct ResetSearchAction: Action {}

