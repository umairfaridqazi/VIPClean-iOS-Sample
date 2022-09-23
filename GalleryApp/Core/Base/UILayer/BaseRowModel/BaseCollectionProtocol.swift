//
//  BaseCollectionProtocol.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension BaseViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension BaseViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = tableViewItems[indexPath.row]
        return item.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewItems[indexPath.row]
        
        // Check Nib cell
        tableView.register(UINib(nibName: item.rowCellIdentifier, bundle: nil), forCellReuseIdentifier: item.rowCellIdentifier)
        if let cellFromNib = tableView.dequeueReusableCell(withIdentifier: item.rowCellIdentifier, for: indexPath) as? BaseTableViewCell {
            cellFromNib.updateCell(rowModel: item)
            return cellFromNib
        }
        
        // Check Storyboard cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.rowCellIdentifier) as? BaseTableViewCell {
            cell.updateCell(rowModel: item)
            return cell
        }
        
        return UITableViewCell()
    }
}
