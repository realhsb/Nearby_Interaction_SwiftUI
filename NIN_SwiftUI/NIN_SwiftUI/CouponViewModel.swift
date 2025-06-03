//
//  CouponViewModel.swift
//  NIN_SwiftUI
//
//  Created by Soop on 5/28/25.
//

import Foundation
import MultipeerConnectivity
import NearbyInteraction

@MainActor
@Observable
class CouponViewModel: ObservableObject {
//    var couponList: [Coupon] = [.stub01, .stub02, .stub03, .stub04, .stub05]
    
    var selectedCoupon: Coupon
    var isConnectWithPeer: Bool = false
    var connectedPeer: MCPeerID?            // 연결된 Peer
    
    var mpc: MultipeerManager?

    init(selectedCoupon: Coupon) {
        self.selectedCoupon = selectedCoupon
    }
    
    func startupMPC() {
        print("CouponViewModel - startupMPC()")
        
        if mpc != nil {
            mpc?.invalidate()
        }
        
        // Prevent Simulator from finding devices.
//        #if targetEnvironment(simulator)
//        mpc = MultipeerManager(myCoupon: selectedCoupon)
//        #else
        let newMPC = MultipeerManager(myCoupon: selectedCoupon)
        newMPC.peerConnectedHandler = connectedToPeer
        newMPC.peerDataHandler = dataReceivedHandler
        newMPC.peerDisconnectedHandler = disconnectedFromPeer
        newMPC.start()
        self.mpc = newMPC
    }
    
    // MPC 연결이 완료되었을 때 호출
    func connectedToPeer(peer: MCPeerID) {
        print("MPC Connected")
        
        
        if connectedPeer != nil {
            fatalError("Already connected to a peer.")
        }
        
        connectedPeer = peer
        isConnectWithPeer = true
    }

    // MPC 연결이 끊겼을 때 실행됨
    func disconnectedFromPeer(peer: MCPeerID) {
        
        print("MPC Disconnected")
        if connectedPeer == peer {
            connectedPeer = nil         // 연결된 Peer id 제거
            isConnectWithPeer = false   // TODO: - 상태 변경 -> enum으로 관리하기
            
        }
    }

    // 상대방이 보내온 NIDiscoveryToken을 수신했을 때 실행
    func dataReceivedHandler(data: Data, peer: MCPeerID) {
        
    }
}
