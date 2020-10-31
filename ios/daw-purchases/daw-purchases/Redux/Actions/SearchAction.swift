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
        }, showLoader: true)
        
        return SearchUserPurchaseProduct()
    }
    
    public static func getProductInfo(productId: Int) -> GetProductInfo {
        _ = SearchState.moyaProvider.request(.getProductById(productId: productId)) { event in
            switch event {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [String: Any] {
                        let product = Mapper<Product>().map(JSON: json)
                        store.dispatch(GetProductInfoAction(productId: productId, results: .success(product)))
                    }
                } catch {
                    store.dispatch(GetProductInfoAction(productId: productId, results: .failure(.somethingWentWrong("Parse Error"))))
                }
                
                break
            case .failure(let error): store.dispatch(GetProductInfoAction(productId: productId, results: .failure(.somethingWentWrong(error.localizedDescription))))
                break
            }
        }
        
        return GetProductInfo()
    }
    
    
    public static func listUserPurchaseProduct(username: String, purchases: [Purchase]) -> ListUserPurchaseProduct {
        let productIds:[Int] = purchases.map { purchase in
            return purchase.productId
        }.unique()
        
        if(productIds.count == 0) {
            store.dispatch(SearchUserPurchaseProductAction(username: username, results: .success([])))
            return ListUserPurchaseProduct()
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
        
        return ListUserPurchaseProduct()
    }
    
    
    
    public static func loadMorePurchases() -> LoadMorePurchases {
        guard let state = store.state, let query = state.searchState.username, let limit = state.searchState.limit else { return LoadMorePurchases() }
        
        _ = SearchState.moyaProvider.request(.getPurchasesByUser(username: query, limit: 10)) { event in
            switch event {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [String: Any], let statuses = json["statuses"] as? [[String : Any]] {
                        
                        let purchases = Mapper<Purchase>().mapArray(JSONArray: statuses)
                        var newLimit: Int? = nil
                        if let lastTweet = purchases.last {
                            newLimit = lastTweet.id
                        }
                        
                        store.dispatch(LoadMorePurchasesAction(results: .success(purchases), limit: newLimit))
                    }
                } catch {
                    store.dispatch(LoadMorePurchasesAction(results: .failure(.somethingWentWrong("Parse Error")), limit: limit))
                }
                
                break
            case .failure(let error): store.dispatch(LoadMorePurchasesAction(results: .failure(.somethingWentWrong(error.localizedDescription)), limit: limit))
                break
            }
        }
        
        return LoadMorePurchases()
    }
}

struct SearchUsers: Action {}
struct SearchPurchasesByUser: Action {}
struct SearchPurchasesByProduct: Action {}
struct SearchUserPurchaseProduct: Action {}
struct GetProductInfo: Action {}

struct ListUserPurchaseProduct: Action {}

struct LoadMorePurchases: Action {}



struct ListUserPurchaseProductAction: Action {
    let results: Result<[Product], APIError>
}

struct SearchUsersAction: Action {
    let username: String
    let results: Result<[User], APIError>
    let limit: Int?
}

struct SearchPurchasesByUserAction: Action {
    let username: String
    let results: Result<[Purchase], APIError>
    let limit: Int?
}

struct SearchPurchasesByProductAction: Action {
    let productId: Int
    let results: Result<[Purchase], APIError>
    let limit: Int?
}

struct SearchUserPurchaseProductAction: Action {
    let username: String
    let results: Result<[Product], APIError>
}

struct GetProductInfoAction: Action {
    let productId: Int
    let results: Result<Product?, APIError>
}



struct LoadMorePurchasesAction: Action {
    let results: Result<[Purchase], APIError>
    let limit: Int?
}

struct ResetSearchAction: Action {}
