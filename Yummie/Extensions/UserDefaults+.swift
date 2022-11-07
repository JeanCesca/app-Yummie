//
//  UserDefaults+.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 07/11/22.
//

import Foundation

extension UserDefaults {
    
    private enum UserDefaultKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
}
