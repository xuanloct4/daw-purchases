//
//  RootRoutable.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwiftRouter

class RootRoutable: Routable {
  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }

  func setToSearchViewController() -> Routable {
    self.window.rootViewController = R.storyboard.search.instantiateInitialViewController()
    
    return SearchViewRoutable(window.rootViewController!)
  }
  
  func changeRouteSegment(
    _ from: RouteElementIdentifier,
    to: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler
    ) -> Routable {
    
    if to == RouteNames.search {
      completionHandler()
      return setToSearchViewController()
    } else {
      fatalError("Route not supported!")
    }
  }
  
  func pushRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler
    ) -> Routable {
    
    if routeElementIdentifier == RouteNames.search {
      completionHandler()
      return setToSearchViewController()
    } else {
      fatalError("Route not supported!")
    }
  }
}
