//
//  BaseNavigationController.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

@objc protocol BaseNavigationControllerDelegate: UINavigationControllerDelegate {
    @objc optional func didSelectRightButton()
    @objc optional func didSelectLeftButton()
}

enum NavigationBarColorScheme: Int {
    case none
    case light
    case dark
}

extension NavigationBarColorScheme {
    var forgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor.appNavigationDefaultForegroundColor()
            
        case .dark:
            return UIColor.appNavigationGreenForegroundColor()
            
        case .none:
            return UIColor.appNavigationDefaultForegroundColor()
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor.appNavigationDefaultBackgroundColor()
            
        case .dark:
            return UIColor.appNavigationGreenBackgroundColor()
            
        case .none:
            return UIColor.appNavigationDefaultBackgroundColor()
        }
    }
    
    var translucent: Bool {
        switch self {
        case .light:
            return true
            
        case .dark:
            return false
            
        case .none:
            return false
        }
    }
}

enum NavigationBarType: Int {
    case cross
    case dots
    case registration
    case hidden
    case profile
    case dashboardNotification
    case dashboardNotificationBadge
    case none = -1
}

class BaseNavigationController: UINavigationController {
    // MARK: - Properties
    
    // __________________________________________________________________________________
    //
    weak var navigationDelegate: BaseNavigationControllerDelegate?
    var rightItem: UIBarButtonItem?
    var leftItem: UIBarButtonItem?
    var colorScheme: NavigationBarColorScheme = .light {
        didSet {
            if colorScheme != oldValue {
                updateColorScheme()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch colorScheme {
        case .dark:
            return .lightContent
        default:
            return .default
        }
    }
    
    var type: NavigationBarType = .none {
        didSet {
            showNavigationBar(animated: false)
        }
    }
    
    // MARK: - Constructors
    
    // __________________________________________________________________________________
    //
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    init(rootViewController: UIViewController?, colorScheme: NavigationBarColorScheme) {
        if let rootVC = rootViewController {
            super.init(rootViewController: rootVC)
        } else {
            super.init()
        }
        self.colorScheme = colorScheme
    }
    
    init(rootViewController: UIViewController?, colorScheme: NavigationBarColorScheme, type: NavigationBarType) {
        if let rootVC = rootViewController {
            super.init(rootViewController: rootVC)
        } else {
            super.init()
        }
        self.colorScheme = colorScheme
        self.type = type
    }
    
    // MARK: - Life Cycle
    
    // __________________________________________________________________________________
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupAppearance()
    }
    
    fileprivate func _setupAppearance() {
        // Remove Shadow
        navigationBar.shadowImage = UIImage()
        
        // Remove Background
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        view.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(forName: NSLocale.currentLocaleDidChangeNotification, object: nil, queue: nil) { _ in
            self.changeDirection()
        }
        
        // Back Button
        _setupBackButton()
        
        // Color Scheme
        updateColorScheme()
        // localized()
    }
    
    func localized() {
            navigationController?.view.semanticContentAttribute = .forceLeftToRight
            navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Helper methods
    
    // __________________________________________________________________________________
    //
    
    private func changeDirection() {
        if UIApplication.isRTL() {
            navigationBar.semanticContentAttribute = .forceRightToLeft
            view.semanticContentAttribute = .forceRightToLeft
        } else {
            navigationBar.semanticContentAttribute = .forceLeftToRight
            view.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    func showNavigationBar(animated: Bool) {
        setNavigationBarHidden(false, animated: animated)
    }
    
    func hideNavigationBar(animated: Bool) {
        setNavigationBarHidden(true, animated: animated)
    }
    
    func hideLeftItemFor(viewController: UIViewController?) {
        if viewController != nil {
            viewController?.navigationItem.leftBarButtonItem = nil
            viewController?.navigationItem.setHidesBackButton(true, animated: false)
        }
    }
    
    func showLeftItemFor(viewController: UIViewController?) {
        if let lItem = leftItem, let vc = viewController {
            vc.navigationItem.leftBarButtonItem = lItem
        }
    }
    
    func hideRightItemFor(viewController: UIViewController?) {
        if let vc = viewController {
            vc.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func showRightItemFor(viewController: UIViewController?) {
        if let rItem = rightItem, let vc = viewController {
            vc.navigationItem.rightBarButtonItem = rItem
        }
    }
    
    // MARK: - Back Button
    
    // __________________________________________________________________________________
    //
    fileprivate func _setupBackButton() {
        // Hide back button text
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -10000, vertical: 0), for: .default)
    }
    
    // MARK: - Navigation Buttons
    
    // __________________________________________________________________________________
    //
    
    func setupNavigationItems(type: NavigationBarType, viewController: UIViewController?) {
        self.type = type
        navigationDelegate = viewController as? BaseNavigationControllerDelegate
        switch type {
        case .cross:
            setRightNavigationItem(getCrossButton(), for: viewController)
            hideLeftItemFor(viewController: viewController)
            
        case .dots:
            setRightNavigationItem(getDotsButton(), for: viewController)
            
        case .registration:
            hideLeftItemFor(viewController: viewController)
            setRightNavigationItem(getDotsButton(), for: viewController)
            
        case .hidden:
            hideLeftItemFor(viewController: viewController)
            hideRightItemFor(viewController: viewController)
            
        case .dashboardNotificationBadge:
            setLeftNavigationItem(getHumbergerNotificationButton(), for: viewController)
            setRightNavigationItem(getQRButton(), for: viewController)
            
        default:
            break
        }
    }
    
    func getCrossButton() -> UIButton? {
        return getButtonWithImageName("large_white_X")
    }
    
    func getDotsButton() -> UIButton? {
        return getButtonWithImageName("iOS_nav icons_more_blue")
    }
    
    func getHumbergerNotificationButton() -> UIButton? {
        return getButtonWithImageName("iOS_nav icons_hamburger_white_circle")
    }
    
    func getButtonImage(fromName imageName: String?) -> UIButton? {
        return getButtonWithImageName(imageName)
    }
    
    func getQRButton() -> UIButton? {
        return getButtonWithImageName("iOS_nav icons_qr code_white")
    }
    
    func getButtonWithImageName(_ imageName: String?) -> UIButton? {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.setImage(UIImage(named: imageName ?? ""), for: .normal)
        return button
    }
    
    func getLocalizationButton() -> UIButton? {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 60)
        button.titleLabel?.text = "العربية"
        button.titleLabel?.textColor = .white
//        button.titleLabel?.font = UIFont.appRegularFont(withSize: 24)
        return button
    }
    
    func setLeftNavigationItem(_ leftItem: UIButton?, for viewController: UIViewController?) {
        if leftItem == nil || viewController == nil {
            return
        }
        leftItem?.addTarget(self, action: #selector(leftItemClicked), for: .touchUpInside)
        self.leftItem = nil
        if let leftItem = leftItem {
            self.leftItem = UIBarButtonItem(customView: leftItem)
        }
        viewController?.navigationItem.leftBarButtonItem = self.leftItem
    }
    
    func setupRightButtonWithText(for viewController: UIViewController?) {
        let rightItem = UIBarButtonItem(title: "العربية", style: .plain, target: self, action: #selector(rightItemClicked))
        rightItem.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.appRegularFont(withSize: 24),
            NSAttributedString.Key.foregroundColor : UIColor.white,
        ], for: .normal)
        self.rightItem = rightItem
        viewController?.navigationItem.rightBarButtonItem = self.rightItem
    }
    
    func setRightNavigationItem(_ rightItem: UIButton?, for viewController: UIViewController?) {
        if rightItem == nil || viewController == nil {
            return
        }
        rightItem?.addTarget(self, action: #selector(rightItemClicked), for: .touchUpInside)
        self.rightItem = nil
        if let rightItem = rightItem {
            self.rightItem = UIBarButtonItem(customView: rightItem)
        }
        viewController?.navigationItem.rightBarButtonItem = self.rightItem
    }
    
    func updateLeftNavigationItem(_ imageName: String?, for viewController: UIViewController?) {
        let leftItem = getButtonWithImageName(imageName)
        if leftItem == nil || viewController == nil {
            return
        }
        leftItem?.addTarget(self, action: #selector(leftItemClicked), for: .touchUpInside)
        self.leftItem = nil
        if let leftItem = leftItem {
            self.leftItem = UIBarButtonItem(customView: leftItem)
        }
        viewController?.navigationItem.leftBarButtonItem = self.leftItem
    }
    
    func updateRightNavigationItem(_ imageName: String?, for viewController: UIViewController?) {
        let rightItem = getButtonWithImageName(imageName)
        if rightItem == nil || viewController == nil {
            return
        }
        rightItem?.addTarget(self, action: #selector(rightItemClicked), for: .touchUpInside)
        self.rightItem = nil
        if let rightItem = rightItem {
            self.rightItem = UIBarButtonItem(customView: rightItem)
        }
        viewController?.navigationItem.rightBarButtonItem = self.rightItem
    }
    
    // MARK: - Actions
    
    // __________________________________________________________________________________
    //
    
    @objc func leftItemClicked() {
        navigationDelegate?.didSelectLeftButton?()
    }
    
    @objc func rightItemClicked() {
        navigationDelegate?.didSelectRightButton?()
    }
    
    // MARK: - Color Scheme
    
    // __________________________________________________________________________________
    //
    func updateColorScheme() {
        if colorScheme == .none {
            hideNavigationBar(animated: true)
            return
        }
        showNavigationBar(animated: true)
        _setupBackgroundAppearance()
        _setupForgroundAppearance()
    }
    
    fileprivate func _setupBackgroundAppearance() {
        navigationBar.barTintColor = colorScheme.backgroundColor
        navigationBar.isTranslucent = colorScheme.translucent
        UIView.animate(withDuration: 0.65, animations: {
            self.navigationBar.layoutIfNeeded()
            
        }) { complete in
            if complete {}
        }
    }
    
    fileprivate func _setupForgroundAppearance() {
        // Set title appearance
        let color = colorScheme.forgroundColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.appSemiBoldFont(withSize: 18)
        ]
        
        navigationBar.tintColor = color
        _refreshColorScheme(with: color)
    }
    
    fileprivate func _refreshColorScheme(with color: UIColor?) {
        DispatchQueue.main.async(execute: {
            for view: UIView in self.navigationBar.subviews {
                let subviews = view.subviews
                for subview: UIView in subviews {
                    if subview.self is UILabel {
                        if let color = color {
                            (subview as? UILabel)?.textColor = color
                        }
                    }
                }
            }
        })
    }
}
