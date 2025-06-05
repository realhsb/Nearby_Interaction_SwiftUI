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

    var selectedCoupon: Coupon
    var isConnectWithPeer: Bool = false
    var connectedPeer: MCPeerID?            // 연결된 Peer
    var currentDistance: Float?
    
    var mpc: MultipeerManager?
    var ni: NearbyInteractionManager?
    
    // NI 거리 정보 컴퓨티드 프로퍼티
    var displayDistance: String {
        guard let distance = ni?.updates.first?.distance else {
            return "측정 중..."
        }
        return String(format: "%.2f m", distance)
    }

    init(selectedCoupon: Coupon) {
        self.selectedCoupon = selectedCoupon
    }
    
    func startupMPC() {
        print("CouponViewModel - startupMPC()")
        
        if mpc != nil {
            mpc?.invalidate()
        }
        
        let newMPC = MultipeerManager(myCoupon: selectedCoupon)
        newMPC.peerConnectedHandler = connectedToPeer
        newMPC.peerDataHandler = dataReceivedHandler
        newMPC.peerDisconnectedHandler = disconnectedFromPeer
        newMPC.start()
        self.mpc = newMPC
    }
    
    func startNI() {
        print("CouponViewModel - startNI()")
        
        
//        if ni != nil {
//            ni?.niSession.invalidate()
//        }
//        
//        if let connectedPeer = connectedPeer, let mpc = mpc {
//            // MPC가 있을 경우 ni 시작
//            print("CouponViewModel - ni 시작, \(connectedPeer)")
//            let newNI = NearbyInteractionManager(peer: connectedPeer)
//            self.ni = newNI
//            
//            // discoveryToken을 공유한 적 없을 때            
//            if ni?.peerDiscoveryToken == nil || ni?.isTokenShared == false {
//                ni?.shareDiscoveryToken(with: connectedPeer, sendDateHandler: mpc.send)
//                print("\(String(describing: ni?.peerDiscoveryToken))")
//            }
//            
//            ni?.runConfiguration(with: connectedPeer)
//            
//            
//        } else {
//            print("MPC 없음. MPC 시작")
//            startupMPC()
//        }
        guard isConnectWithPeer, let connectedPeer = connectedPeer, let mpc = mpc else {
                print("❌ 연결된 peer 없음 또는 MPC 없음")
                return
            }

            // 기존 세션 invalidate
            ni?.niSession.invalidate()

            // 새 NI 매니저 생성
            let newNI = NearbyInteractionManager(peer: connectedPeer)
            self.ni = newNI

            // 내 discoveryToken 보내기
            if newNI.peerDiscoveryToken == nil || newNI.isTokenShared == false {
                newNI.shareDiscoveryToken(with: connectedPeer, sendDateHandler: mpc.send)
            }

            // peer token 이미 받았으면 바로 config 실행
            if newNI.peerDiscoveryToken != nil {
                newNI.runConfiguration(with: connectedPeer)
            }
    }
    
    // TODO: Move to MPC Manager
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
        
        ni?.invalidateInteraction(with: peer)
    }

    // 상대방이 보내온 NIDiscoveryToken을 수신했을 때 실행
    func dataReceivedHandler(data: Data, peer: MCPeerID) {
        // discoveryToken을 서로 공유했다면, ni 시작
        print("상대방이 보내온 NIDiscoveryToken을 수신했을 때 실행")
        // 1. peerToken 저장
        ni?.peerTokenReceived(for: peer, data: data)

        // 2. runConfiguration 실행
        if ni?.isTokenShared == true {
            ni?.runConfiguration(with: peer)
        }
    }
}
