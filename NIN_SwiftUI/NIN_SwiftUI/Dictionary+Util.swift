//
//  Dictionary+Util.swift
//  NIN_SwiftUI
//
//  Created by Soop on 5/29/25.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    var jsonData: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
