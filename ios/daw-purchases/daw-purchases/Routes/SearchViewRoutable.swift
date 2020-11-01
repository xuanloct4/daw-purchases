//
//  SearchViewRoutable.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwiftRouter

class SearchViewRoutable: Routable {
  
  let viewController: UIViewController
  
  init(_ viewController: UIViewController) {
    self.viewController = viewController
  }
  
  func pushRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    
    if routeElementIdentifier == RouteNames.detail {
      let detailController = R.storyboard.detail.instantiateInitialViewController()!
      
      (viewController as! UINavigationController).pushViewController(detailController, animated: animated)
      completionHandler()
      return DetailViewRoutable()
    }
    
    fatalError("Cannot handle this route change!")
  }
  
  public func popRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) {
    
//    store.dispatch(DetailAction(product: nil))
    completionHandler()
  }
  
  public func changeRouteSegment(
    _ from: RouteElementIdentifier,
    to: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    completionHandler()
    return SearchViewRoutable(viewController)
    
  }
}
