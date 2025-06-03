//
//  String+Util.swift
//  NIN_SwiftUI
//
//  Created by Soop on 5/28/25.
//

import SwiftUI

extension String {

    var data: Data? {
        self.data(using: .utf8)
    }
}
