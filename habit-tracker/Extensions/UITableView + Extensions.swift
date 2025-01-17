//
//  UITableView + Extensions.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//


import UIKit

typealias UITableViewDelegateAndDataSource = UITableViewDelegate & UITableViewDataSource

extension UITableView {
    
    func registerHeaderNib<Cell: UITableViewHeaderFooterView>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: Cell.self))
    }
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UITableViewCell>(cellClass: Cell.Type) -> Cell {
        let identifier = String(describing: cellClass.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in dequeueing cell")
        }
        return cell
    }

    func initialize<Cell: UITableViewCell>(cellClass: Cell.Type? = nil, delegate: UITableViewDelegate, dataSource: UITableViewDataSource, estimatedRowHeight: CGFloat? = nil, refreshControl: UIRefreshControl? = nil, headerView: UIView? = nil, footerView: UIView? = UIView(), edgeInsets: UIEdgeInsets? = nil) {
        if cellClass != nil {
            self.registerCellNib(cellClass: cellClass!)
        }
        self.dataSource = dataSource
        self.delegate = delegate
        self.refreshControl = refreshControl
        self.tableHeaderView = headerView
        self.tableFooterView = footerView
        if estimatedRowHeight != nil {
            self.estimatedRowHeight = estimatedRowHeight!
        }
        self.contentInset = edgeInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.rowHeight = UITableView.automaticDimension
    }
}


// MARK: - Get Index Path
extension UITableViewCell {
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
}
