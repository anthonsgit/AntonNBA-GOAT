//
//  Bundle+displayName.swift
//  SecureBrowser
//
//  Created by Stas on 01.05.21.
//

import Foundation

public extension Bundle { 
    var displayName: String {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
            ?? ""
    }
}
