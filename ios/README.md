# Discount Ascii Warehouse iOS Application

This mobile application use ReSwift frame work due to its `Redux-like implementation of the unidirectional data flow architecture in Swift`

In combination with RxSwift that makes the application follow `Reactive programming`

For more information about the ReSwift, refer to [ReSwift](https://github.com/ReSwift/ReSwift)

For more information about the RxSwift and how to use it, refer to [RxSwift](https://github.com/ReactiveX/RxSwift)

## UI Flow
The following diagram represents Flow of the application

![App Flow](/images/app_flow.png)

## Build
Source code for the application can be built successfully using
* Xcode 11.5+
* MacOS 11.15+
* Swift 5
* Cocoapod 1.9.1+ (Required if need to update the pods, install by simply issuing command `sudo gem install cocoapods` in the Terminal)

The source already included all the required pods, in order to build and run the app, just open the daw-purchases.xcworkspace in Xcode app and click  Build or Run
If you want to update the pods, e.g ReSwiftRouter, issue the following commands before build the application 
```
cd <path/to/the/directory/contains/daw-purchases.xcworkspace>
pod update
```

## Code Organization
The source code of the application is grouped into groups with structure as below
* Extensions
            The Extensions group contains class extension of most common used class like String, Sequence, Collection View, Label
* Globals
            The Globals group contains some Utilities class for date conversion (DateUtil), Sizes, APIError(Errors)
* Models
            The group contains Entity's models of the data from the API such as User, Purchase, Product.
* Redux
            Redux contains the Store(Store<AppState>) a single data structure that stores entire app state. Whenever the state in the store changes, the store will notify all observers.
            
            The Redux group is divided into 3 subgroups: States, Actions, Reducers
            
            - As its name suggested, the States contains states for features.
            The SearchState corrresponding to the Search Purchase screen.
            The DetailState corrresponding to the Detail screen.
            And the AppState includes both NavigationState, SearchState and DetailState
            
            - The Actions contains functions that describe state change for State.
            There are also Actions corresponding to States like SearchAction, DetailAction
            
            - The Reducers contains the functions help to cretae new state base on current state and action. 
            The State can be modified by dispatching Actions to the Store
            The Reducers includes AppReducer, SearchReducer and DetailReducer
            
* Routes
            The application's navigation implementation based on the ReSwiftRouter.
            This group include the Router for defining the Router and RouteNames
            and Routables (RootRoutable, RootRoutable, DetailViewRoutable)
            each Routable would define how and when to push(pushRouteSegment), pop(popRouteSegment) or change(changeRouteSegment)
* Scenes
            This group contains ViewControllers, storyboards, xibs for the UI

* Providers
            The Provider group contains classes relate to Networking.
            The application uses Moya framework, the DAWProvider define paths, baseURL, method, headers, task
            The NetworkService contains convenient methods for sending request and mapping data to the Model, returned data is in form of Data Model or Observables 

* R.generated.swift
            By using R.swift, the R.generated.swift was automatically generated.
            All resources such as nib, storyboard, reuseIdentifier, bundle, string, .etc could be used in form of structs instead of retrieving by its name

## Architecture

The application follows standard ReSwift MVVM architecture

![Reswift](/images/reswift_concept.png)

![MVVM](/images/MVVM_concept.png)


## Sequence Diagram


## Unit test
The application was not fully implemented unit tests for all components.
For illustration purpose, the Redux components are unit tested only
* SearchReducerTests, AppReducerTests and DetailReducerTests: unit tests for Reducers
* StoreTests: unit tests for Store's DispatchAction, StoreSubscriber


## Screenshot
Following images is screenshot for the application

![Search Empty](/screenshots/Search_Empty.png)

![Search Found](/screenshots/Search_Found.png)

![Search Not Found](/screenshots/Search_Not_Found.png)

![Product Detail](/screenshots/Product_Detail.png)




