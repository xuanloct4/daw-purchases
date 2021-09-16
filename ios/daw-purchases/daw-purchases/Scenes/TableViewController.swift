//
//  TableViewController.swift
//  daw-purchases
//
//  Created by Tran Loc on 09/09/2021.
//  Copyright © 2021 Tran Loc. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

struct CustomData {
  var anInt: Int
  var aString: String
  var aCGPoint: CGPoint
}

struct SectionOfCustomData {
  var header: String
  var items: [Item]
    var footer: String
}

extension SectionOfCustomData: SectionModelType {
  typealias Item = CustomData

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}


class TableViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(resource: R.nib.tableViewCell), forCellReuseIdentifier: R.reuseIdentifier.tableViewCell.identifier)

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
          configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.tableViewCell.identifier, for: indexPath)
            cell.textLabel?.text = "Item \(item.anInt): \(item.aString) - \(item.aCGPoint.x):\(item.aCGPoint.y)"
            return cell
        })


        dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }

        dataSource.titleForFooterInSection = { dataSource, index in
          return dataSource.sectionModels[index].footer
        }

        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
          return true
        }

        dataSource.canMoveRowAtIndexPath = { dataSource, indexPath in
          return true
        }



        let sections = [
          SectionOfCustomData(header: "First section", items: [CustomData(anInt: 0, aString: "zero", aCGPoint: CGPoint.zero), CustomData(anInt: 1, aString: "one", aCGPoint: CGPoint(x: 1, y: 1)) ], footer: "First footer"),
          SectionOfCustomData(header: "Second section", items: [CustomData(anInt: 2, aString: "two", aCGPoint: CGPoint(x: 2, y: 2)), CustomData(anInt: 3, aString: "three", aCGPoint: CGPoint(x: 3, y: 3)) ], footer: "Second footer")
        ]

//        Observable.just(sections)
//          .bind(to: tableView.rx.items(dataSource: dataSource))
//          .disposed(by: disposeBag)

        let d1 = CustomData(anInt: 0, aString: "zero", aCGPoint: CGPoint.zero)
        let d2 = CustomData(anInt: 1, aString: "one", aCGPoint: CGPoint(x: 1, y: 1))
        let l: [CustomData] = [d1, d2]
//        let o : Observable<[CustomData]> = Observable.from(optional: l)
        let o1 = Observable.of(d1, d2)
//        let o = Observable.from(optional: l)
//            o.bind(to: tableView.rx.items(cellIdentifier:  R.reuseIdentifier.tableViewCell.identifier, cellType: TableViewCell.self)) { row, element, cell in
//            cell.textLabel?.text = "Item \(element.anInt): \(element.aString) - \(element.aCGPoint.x):\(element.aCGPoint.y)"
//
//        }.disposed(by: disposeBag)



//        o1.observeOn(MainScheduler.instance).subscribe(onNext: { d in
//            print("subscribe onNext \(d)")
//        }, onError: { d in
//            print("subscribe onError \(d)")
//        }, onCompleted: {
//            print("subscribe onCompleted ")
//        }, onDisposed: {}).disposed(by: disposeBag)


//        let subject = PublishSubject<CustomData>()
//        subject.onNext(d1)
//        let subject = BehaviorSubject<CustomData>(value: d1)
        let subject = BehaviorRelay<CustomData>(value: d1)

        let subscriptionOne = subject
        .subscribe(onNext: { d in
            print(" subscriptionOne - subscribe onNext - \(d)")
        }).disposed(by: disposeBag)

//        subject.onNext(d2)
        subject.accept(d2)

        let subscriptionTwo = subject
        .subscribe(onNext: { d in
        print(" subscriptionTwo - subscribe onNext - \(d)")
        }).disposed(by: disposeBag)

//        subject.on(.next(d1))
        subject.accept(d1)


        let subject1 = BehaviorRelay<[CustomData]>(value: [d1])
        subject1.asDriver().drive(onNext: { items in
            print("Drive onNext: \(items)")
        }, onCompleted: {
            print("Drive onCompleted")
        }, onDisposed: {
            print("Drive onDisposed")
        }).disposed(by: disposeBag)


//        subject1.asObservable().bind(to: tableView.rx.items(cellIdentifier:  R.reuseIdentifier.tableViewCell.identifier, cellType: TableViewCell.self)) { row, element, cell in
//            cell.textLabel?.text = "Item \(element.anInt): \(element.aString) - \(element.aCGPoint.x):\(element.aCGPoint.y)"
//
//        }.disposed(by: disposeBag)

        subject1.asDriver().drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.tableViewCell.identifier)) { ( row, element, cell) in
            cell.textLabel?.text = "Item \(element.anInt): \(element.aString) - \(element.aCGPoint.x):\(element.aCGPoint.y)"
           }
           .disposed(by: disposeBag)


        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            subject1.accept([d1,d2])
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            subject1.accept([d2])
        })
    }
}
