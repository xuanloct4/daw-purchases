//
//  DetailViewController.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class DetailViewController: UIViewController, Routable {
  typealias StoreSubscriberStateType = DetailState
  
  @IBOutlet weak var faceLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var sizeLabel: UILabel!
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    store.subscribe(self) {
      $0.select {
        $0.detailState
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    store.unsubscribe(self)
  }
}

extension DetailViewController: StoreSubscriber {
  func newState(state: DetailState) {
    if let product = state.product {
        faceLabel.text = product.product?.face ?? ""
        priceLabel.text = "Price: \(String(describing: product.product?.price ?? 0))"
        sizeLabel.text = "Size: \(String(describing: product.product?.size ?? 0))"
    }
  }
}
