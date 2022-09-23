//
//  UITableView.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ResuableViews {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier )
    }
    
   
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>(_: T.Type, for section: Int) -> T where T: ResuableViews{
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
            else { fatalError("Could not deque cell with type \(T.self)")
        }
        return cell
    }
    
    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
    }
}

