//
//  BaseViewController.swift
//  daw-purchases
//
//  Created by Tran Loc on 13/09/2021.
//  Copyright © 2021 Tran Loc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    
    let simpleOver = SimpleOver()
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        simpleOver.popStyle = (operation == .pop)
        return simpleOver
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
    }
    
    func configureNavigation() {
        navigationController?.delegate = self
    }
    
    func configureTableView() {
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}

extension BaseViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
}


extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


extension BaseViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    }
}
