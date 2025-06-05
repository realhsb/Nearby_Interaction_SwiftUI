////
////  NearbyInteractionManager.swift
////  NIN_SwiftUI
////
////  Created by Soop on 5/29/25.
////
//
//import Foundation
//import NearbyInteraction
//import MultipeerConnectivity
//
////@MainActor
//@Observable
//class NearbyInteractionManager: NSObject {
//    
//    var niSession: NISession
//    var peerDiscoveryToken: NIDiscoveryToken?
//    var isTokenShared: Bool = false
//    var updates: [NINearbyObject] = []
//    var connectedPeer: MCPeerID?
////    var distance: NSObject
////    
////    struct NIObject {
////        var distance: Float?
////        var direction: simd_float3?
////    }
//    
//    init(peer: MCPeerID) {
//        print("NI 초기화")
//        self.niSession = NISession()
//        self.connectedPeer = peer
//        super.init()
//        
//        niSession.delegate = self
//        
//        // Because the session is new, reset the token-shared flag.
//        isTokenShared = false
//    }
//}
//
//extension NearbyInteractionManager {
//    @MainActor
//    func initNI(_ peer: MCPeerID) {
//        self.niSession = NISession()
//        niSession.delegate = self
//    }
//    
//    // NI reset
//    @MainActor
//    func reset() {
//        self.niSession.invalidate()
//        self.peerDiscoveryToken = nil
//        self.isTokenShared = false
//        self.updates = []
////        self.connectedPeer = nil
//    }
//    
//    @MainActor
//    func shareDiscoveryToken(with peerID: MCPeerID, sendDateHandler: @escaping (Data, MCPeerID) -> Void) {
//        print("NINmanager - shareDiscoveryToken()")
//        // (1) NI 사용 가능한 모델인지 확인
//        if !checkAvailability() { return }
//        
//        // (2) 이미 discoveryToken이 공유됐는지 확인 (tokenShared)
//        if self.isTokenShared {
//            // 이미 공유했다면 종료
//            return
//        }
//        
//        // (3) NISession으로부터 내 기기의 discoveryToken 가져오기
//        guard let token = niSession.discoveryToken, let data = try? NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true) else {
//            // TODO: - Error (DiscoveryToken Creation Failed)
//            print("나의 discoveryToken 생성 실패")
//            return
//        }
//        
//        // (4) 연결된 peerID와 discoveryToken(data) 공유하기
//        //     이때 MPCManager로부터 data send 메서드 핸들러로 받아오기
//        print("sharing token with peer \(peerID.displayName)")
//        sendDateHandler(data, peerID)
//        
//        // (5) 토큰 공유 완료 상태 체크(tokenShared)
//        self.isTokenShared = true
//    
//    }
//    
//    /// peer로부터 받은 데이터에서 discoveryToken으로 변환
//    @MainActor
//    func peerTokenReceived(for peerID: MCPeerID, data: Data) {
//        print("NIManager - peerTokenReceived() called")
//            
//            if let token = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) {
//                self.peerDiscoveryToken = token
//                print("NIManager - peer token set!")
//            } else {
//                print("❌ peer token decoding 실패")
//            }
//    }
//    
//    /// peer의 discoveryToken을 통해 config 파일 생성 후, NISession run()
//    @MainActor
//    func runConfiguration(with peerID: MCPeerID) {
//        print("NI - runConfiguration")
//        if !checkAvailability() { return }
//        
//        guard let peerToken = peerDiscoveryToken else {
//            print("귀찮아서 ...")
//            return
//        }
//        
//        print("NI - runConfiguration - peerToken 확인")
//        let config = NINearbyPeerConfiguration(peerToken: peerToken)
//        print("NI - runConfiguration - 세션 run()")
//        niSession.run(config)
//    }
//    
//    @MainActor
//    func invalidateInteraction(with peerID: MCPeerID) {
//        print("NINmanager - invalidateInteraction()")
//        self.niSession.invalidate()
////        connectedPeer = nil
//    }
//    
//    private func checkAvailability() -> Bool {
//        if !NISession.deviceCapabilities.supportsPreciseDistanceMeasurement {
//            //TODO: - Error(Device Unsupported)
//            print("지원하지 않는 모델입니다.")
//            return false
//        }
//        
//        return true
//    }
//    
//    // TODO: - 50m이내인지 확인
//    private func checkDistanceThreshold() {
//        print("NINmanager - checkDistanceThreshold()")
//        guard let currentDistance = updates.first?.distance else { return }
//        
//        if currentDistance < 0.5 {
////            NotificationCenter.default.post(name: .couponActivation, object: nil)
//            print("0.5m 이내입니다")
//        }
//    }
//}
//
//extension NearbyInteractionManager: NISessionDelegate {
//    
//
//    
//    // Reacting to session start
//    /// functions for session that call session.starts
//    func sessionDidStartRunning(_ session: NISession) {
//        print("NIManager - session started running")
//    }
//    
//    // Managing interruption
//    /// session suspend due to own device
//    func sessionWasSuspended(_ session: NISession) {
//        print("NIManager - session was suspended")
//    }
//    
//    /// Session suspension ended. The session can now be run again.
//    func sessionSuspensionEnded(_ session: NISession) {
//        
//        print("NIManager - session suspension ended")
//        if let config = session.configuration {
//            session.run(config)
//        }
//    }
//    
//    // Monitoring peers
//    /// Notifies you when the session updates nearby objects.
//    /// 세션에 참여하는 상대 peer의 업데이트된 NINearbyObject 객체를 전달 받음
//    /// peerDiscovery가 있을 경우 세션을 통한 업데이트 진행
//    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
//        print("위치 공유 시작")
//        let token = peerDiscoveryToken
//        let matchedObjects = nearbyObjects.filter { $0.discoveryToken == token }
//
//        if let update = matchedObjects.first {
//            // 거리 업데이트
//            DispatchQueue.main.async {
//                print("\(String(describing: update.distance))")
//                self.updates.insert(update, at: 0)
//                print("\(String(describing: update.distance))")
//            }
//        }
//        
//        
//        
//        
//    }
//    
//    /// Notifies you when the session removes one or more nearby objects.
//    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
////        print("\(newa)")
//        guard let token = peerDiscoveryToken, let removal = nearbyObjects.first(where: { $0.discoveryToken == token }) else { return }
//        print("remove session")
//    }
//
//
//}
