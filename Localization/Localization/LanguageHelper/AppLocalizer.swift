//
//  AppLocalizer.swift
//  Localization
//
//  Created by Balu Naik on 6/10/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class AppLocalizer: NSObject {
    
    class func doTheSwizzling() {
        /*  Step#: 1
           - We exchange the implementation of "localizedStringForKey:value:table:" with
           - our "specialLocalizedStringForKey:value:table:",
           - passing the class which is Bundle(.self to reference the object type).
        */
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.shared.cstm_userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.shared.cstm_userInterfaceLayoutDirection))
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
    }
    
}

// MARK: - Bundle extension
// This will tell us language specific Bundle to be load
extension Bundle {
    
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        //Step#:2 we get the preferred language.(e.g. en)
        let currentLanguage = LanguageManager.getCurrentLanguage()
        var bundle = Bundle()
        /*Step#: 3 we check if there is a bundle for that language (e.g. en.lproj), if not we user Base.proj, and we get store a reference in bundle var. */
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        
        return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
    }
}

// MARK: - UIApplication extension

extension UIApplication {
    
    class func isRTL() -> Bool {
        
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    @objc var cstm_userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if LanguageManager.getCurrentLanguage() == "ar" {
                direction = .rightToLeft
            }
            
            return direction
        }
    }
}

extension UITextField {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.tag <= 0 {
            if UIApplication.isRTL()  {
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}

// Exchange the implementation of two methods for the same Class

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    if let origMethod: Method = class_getInstanceMethod(cls, originalSelector),
        let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) {
        if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, overrideMethod);
        }
    }
}

