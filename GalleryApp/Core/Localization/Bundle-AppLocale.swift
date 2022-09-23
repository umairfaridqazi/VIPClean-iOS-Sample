//
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    open override func awakeFromNib() {
        super.awakeFromNib()
    }

}

public final class LocalizedBundle: Bundle {
    public override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = Bundle.main.localizedBundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}

public extension Bundle {
    private struct AssociatedKeys {
        static var b = "LocalizedMainBundle"
    }

    fileprivate var localizedBundle: Bundle? {
        return objc_getAssociatedObject(self, &AssociatedKeys.b) as? Bundle
    }

    static func enforceLanguage(_ code: String) {
        guard let path = Bundle.main.path(forResource: code, ofType: "lproj") else { return }
        guard let bundle = Bundle(path: path) else { return }

        //    prepare translated bundle for chosen language and
        //    save it as property of the Bundle.main
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.b, bundle, .OBJC_ASSOCIATION_RETAIN)

        //    now override class of the main bundle (only once during the app lifetime)
        //    this way, `localizedString(forKey:value:table)` method in our subclass above will actually be called
        DispatchQueue.once(token: AssociatedKeys.b) {
            object_setClass(Bundle.main, LocalizedBundle.self)
        }
    }

    static func clearInAppOverrides() {
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.b, nil, .OBJC_ASSOCIATION_RETAIN)
    }
}
