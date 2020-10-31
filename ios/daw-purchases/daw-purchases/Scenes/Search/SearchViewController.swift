//
//  SearchViewController.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import RxCocoa
import RxSwift
import Result
import ReRxSwift

class SearchViewController: UIViewController, Routable {
  let notFoundMessage = "User with username of '%s' was not found"
    
  let connection = Connection(store: store,
                              mapStateToProps: mapStateToProps,
                              mapDispatchToActions: mapDispatchToActions)
  
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var results: [Product] = []
  private var didChangeQuery: PublishSubject = PublishSubject<Void>()
  private var didChangeLimit: PublishSubject = PublishSubject<Void>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    
//    Observable.combineLatest(didChangeQuery, didChangeLimit)
//      .subscribe(onNext: { [weak self] _ in
//        self?.updateData()
//      })
//      .disposed(by: disposeBag)
    
    didChangeQuery.subscribe(onNext: {[weak self] _ in
                self?.updateData()
        }).disposed(by: disposeBag)
    
    connection.subscribe(\Props.username) { [weak self] query in
      self?.didChangeQuery.onNext(())
    }
    
    connection.subscribe(\Props.limit) { [weak self] limit in
      // do nil check for preventing in order to reloading twice
      if limit != nil {
        self?.didChangeLimit.onNext(())
      }
    }
    
    searchBar.rx.text
      .orEmpty // Make it non-optional
      .skip(1)
      .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] text in
        if text != "" {
          self?.actions.search(text)
            self?.collectionView.setEmptyMessage(String(format: "User with username of '%@' was not found", text) )
        } else {
          self?.actions.resetSearch()
            self?.collectionView.setEmptyMessage("")
        }
      })
      .disposed(by: disposeBag)
  }
  
  private func updateData() {
    if let results = store.state.searchState.productResults {
      switch results {
      case let .success(product):
        self.results = product
        break
      case let .failure(APIError.somethingWentWrong(error)):
        print("Error: \(error)")
        self.results.removeAll()
        break
      }
      
      self.collectionView.reloadData()
    } else {
      // Reset
      self.results.removeAll()
      self.collectionView.reloadData()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    store.subscribe(self) {
      $0.select {
        $0.searchState
      }
    }
    
    connection.connect()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if store.state.navigationState.route != [RouteNames.search] {
      actions.setRoute([RouteNames.search])
      updateData()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    connection.disconnect()
    store.unsubscribe(self)
  }
  
  private func configureCollectionView() {
    collectionView.register(R.nib.productCell(), forCellWithReuseIdentifier: R.reuseIdentifier.productCell.identifier)
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      if #available(iOS 10.0, *) {
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
      }
      else {
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
      }
      
    }
    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

extension SearchViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let product = results[indexPath.item]
    
    actions.setDetail(product)
    actions.setRoute([RouteNames.search, RouteNames.detail])
  }
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.productCell.identifier, for: indexPath) as? ProductCell {
      
      productCell.model = results[indexPath.row]
      
      return productCell
    }
    
    return UICollectionViewCell()
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if searchBar.canResignFirstResponder {
      searchBar.resignFirstResponder()
    }
  }
}


extension SearchViewController: StoreSubscriber {
  func newState(state: SearchState) {
//    if let result = state.purchaseResults {
//            switch result {
//            case let .success(purchases):
//                if (purchases.count > 0) {
//                    actions.listUserPurchaseProduct(purchases)
//                }
//              break
//            case .failure(_):
//              break
//            }
//    }
//
    if let r = state.productResult {
              updateData()
       }

  }
}

extension SearchViewController: Connectable {
  struct Props {
    let username: String?
    let limit: Int?
  }
  struct Actions {
    let search: (_ query: String) -> ()
    let listUserPurchaseProduct: (_ username: String, _ purchases: [Purchase]) -> ()
    let loadMore: () -> ()
    let resetSearch: () -> ()
    let setDetail: (_ product: Product) -> ()
    let setRoute: (Route) -> ()
  }
}

private let mapStateToProps = { (appState: AppState) in
  return SearchViewController.Props(
    username: appState.searchState.username,
    limit: appState.searchState.limit
  )
}

private let mapDispatchToActions = { (dispatch: @escaping DispatchFunction) in
  return SearchViewController.Actions(
    search: { newQuery in dispatch(SearchState.searchUsersPurchaseProduct(username: newQuery, limit: 5)) },
    listUserPurchaseProduct: { username, purchases in dispatch(SearchState.listUserPurchaseProduct(username: username, purchases: purchases))},
    loadMore: { dispatch(SearchState.loadMorePurchases()) },
    resetSearch: { dispatch(ResetSearchAction()) },
    setDetail: { product in dispatch(DetailAction(product: product)) },
    setRoute: { route in dispatch(ReSwiftRouter.SetRouteAction(route)) }
  )
}
