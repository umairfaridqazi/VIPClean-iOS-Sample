//
//  UIViewController.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

// MARK: - extension

extension UIViewController {
    // MARK: properties

    // UIViewController storyboard ID
    static var storyboardID: String {
        return "\(self)"
    }

    // MARK: - Handler method

    // instatiate UIViewController instance
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

    // MARK: enum

    // Storyboard name
    enum AppStoryboard: String {
        case Splash
        case MainListing

        var instance: UIStoryboard {
            return UIStoryboard(name: rawValue, bundle: Bundle.main)
        }

        func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
            let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
            return instance.instantiateViewController(withIdentifier: storyboardID) as! T
        }

        func initialViewController() -> UIViewController? {
            return instance.instantiateInitialViewController()
        }
    }

    func dismissMe(completion: ((Bool) -> Void)? = nil) {
        if let navigationViewController = self.navigationController {
            if navigationViewController.viewControllers.count >= 1 {
                dismissPushedController()
            } else {
                dismissPresentedController()
            }

        } else {
            dismissPresentedController()
        }
        completion?(true)
    }

    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }

    fileprivate func dismissPushedController() {
        _ = navigationController?.popViewController(animated: true)
    }

    fileprivate func dismissPresentedController(completion: ((Bool) -> Void)? = nil) {
        dismiss(animated: true, completion: { () -> Void in
            print("\(String(describing: type(of: self))) is dismiss.")
            completion?(true)
        })
    }

    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }

    func topmostViewController() -> UIViewController {
        if let navigationVC = self as? UINavigationController,
            let topVC = navigationVC.topViewController {
            return topVC.topmostViewController()
        }
        if let tabBarVC = self as? UITabBarController,
            let selectedVC = tabBarVC.selectedViewController {
            return selectedVC.topmostViewController()
        }
        if let presentedVC = presentedViewController {
            return presentedVC.topmostViewController()
        }
        if let childVC = children.last {
            return childVC.topmostViewController()
        }
        return self
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController.isKind(of: toControllerType) {
                    navigationController?.popToViewController(currentViewController, animated: true)
                    break
                }
            }
        }
    }
}
