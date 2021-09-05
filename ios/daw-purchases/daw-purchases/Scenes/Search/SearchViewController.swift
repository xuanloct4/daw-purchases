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
    let notFoundMessage = "User with username of '%@' was not found"
    let limit = 5
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
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                if text != "" {
                    self?.actions.search(text, self?.limit)
                } else {
                    self?.actions.resetSearch()
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
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func configureCollectionView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        collectionView.register(UINib(resource: R.nib.productCell), forCellWithReuseIdentifier: R.reuseIdentifier.productCell.identifier)
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
        let searchText = searchBar.text ?? ""
        if(!searchText.isEmpty && results.count == 0) {
            self.collectionView.setEmptyMessage(String(format: self.notFoundMessage, searchText) )
        } else {
            self.collectionView.setEmptyMessage("")
        }
        
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

extension SearchViewController: Connectable {
    struct Props {
        let username: String?
        let limit: Int?
    }
    struct Actions {
        let search: (_ query: String, _ limit: Int?) -> ()
        let listUserPurchaseProduct: (_ username: String, _ purchases: [Purchase]) -> ()
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
        search: { newQuery, limit in dispatch(SearchAction.searchUsersPurchaseProduct(username: newQuery, limit: limit)) },
        listUserPurchaseProduct: { username, purchases in dispatch(SearchAction.listUserPurchaseProduct(username: username, purchases: purchases))},
        resetSearch: { dispatch(ResetSearchAction()) },
        setDetail: { product in dispatch(DetailAction(product: product)) },
        setRoute: { route in dispatch(ReSwiftRouter.SetRouteAction(route)) }
    )
}
