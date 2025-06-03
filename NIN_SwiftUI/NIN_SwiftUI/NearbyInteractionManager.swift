//
//  NearbyInteractionManager.swift
//  NIN_SwiftUI
//
//  Created by Soop on 5/29/25.
//

import Foundation
import NearbyInteraction

@Observable
class NearbyInteractionManager: NSObject {
    private var session: NISession?
    private var peerToken: NIDiscoveryToken?
}

extension NearbyInteractionManager: NISessionDelegate {
    
}
