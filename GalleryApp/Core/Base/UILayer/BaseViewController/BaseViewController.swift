//
//  BaseViewController.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView?

    var colorScheme = NavigationBarColorScheme.light
    var tableViewItems = [BaseRowModel]()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupLocalizedAppearance()
        setupBackground()
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }

    func setupAppearance() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
    }

    func setupBackground() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        setNeedsStatusBarAppearanceUpdate()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _applyTheme()
    }

    open override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            _applyBackTheme()
            super.willMove(toParent: parent)
        }
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }
}

// Localization
extension BaseViewController {
    @objc func setupLocalizedAppearance() {}

    @objc func languageChanged() {
        _refreshLocalization()
        setupLocalizedAppearance()
    }

    private func _refreshLocalization() {
        for v in view.subviews {
            if let localizableView = v as? LocalizableView, let localizable = localizableView as? Localizable {
                if let text = localizableView.localizedKey {
                    if !text.isEmpty {
                        localizable.applyLocalizableString(localizableView.localizedKey)
                    }
                }
            }
        }
    }
}

// Navigation Bar
extension BaseViewController {
    private func _applyTheme() {
        if let navController = navigationController as? BaseNavigationController {
            navController.colorScheme = colorScheme
        }
    }

    private func _applyBackTheme() {
        if let viewControllers = navigationController?.viewControllers {
            if viewControllers.count > 1 {
                if let vc = viewControllers[viewControllers.count - 2] as? BaseViewController, let navController = navigationController as? BaseNavigationController {
                    navController.colorScheme = vc.colorScheme
                }
            }
        }
    }
}
