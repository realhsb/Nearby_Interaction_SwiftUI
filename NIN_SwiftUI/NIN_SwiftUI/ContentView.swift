//
//  ContentView.swift
//  NIN_SwiftUI
//
//  Created by Soop on 5/25/25.
//

import SwiftUI

struct ContentView: View {
    
//    var viewModel: CouponViewModel = CouponViewModel(selectedCoupon: <#Coupon#>)
    
    var couponList: [Coupon] = [.stub01, .stub02, .stub03, .stub04, .stub05]
    
    var body: some View {
        NavigationStack {
            CouponList()
        }
    }
    
    @ViewBuilder
    func CouponList() -> some View {
        VStack {
            ForEach(couponList) { coupon in
                
                
                NavigationLink{
                    CouponView(viewModel: .init(selectedCoupon: coupon))
                        
                } label: {
                    VStack {
                        Text(coupon.title)
                        Text(coupon.couponId)
                    }
                    .padding()
                    .frame(width: 200)
                    .foregroundStyle(Color.white)
                    .background(Color.gray)
                }
                
            }
        }
    }
    
    func couponDetailView(coupon: Coupon) -> some View {
        VStack {
            Text("세션")
            
            Text(coupon.couponId)
            Text(coupon.title)
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                Button {
                    
                } label: {
                    Text("확인")
                }
                
                Button {
                    // TODO: - MPC 세션 연결 가능할 때 버튼 활성화
                    
                } label: {
                    Text("사용하기")
                }
                
            }
        }
    }
    
    struct CouponView: View {
        var viewModel: CouponViewModel
        
        var body: some View {
            VStack {
                Text("세션")
                
                Text(viewModel.selectedCoupon.couponId)
                Text(viewModel.selectedCoupon.title)
                
                Text("\(viewModel.isConnectWithPeer)")
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("확인")
                    }
                    
                    Button {
                        // TODO: - MPC 세션 연결 가능할 때 버튼 활성화
                        
                    } label: {
                        Text("사용하기")
                    }
                    .disabled(!viewModel.isConnectWithPeer)
                    
                }
            }
            .onAppear {
                viewModel.startupMPC()
            }
            .onDisappear {
                        viewModel.mpc?.invalidate()
                    }
        }
    }
}

#Preview {
    ContentView()
}
