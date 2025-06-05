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
                    NavigationLink {
                        CouponInteractionView(viewModel: viewModel)
                    } label: {
                        Text("사용하기")
                    }
                    .disabled(!viewModel.isConnectWithPeer)
                }
            }
            .onAppear {
                viewModel.startupMPC()
            }
            // 뒤로가기 할 때 세션이 종료되도록 한다.
//            .onDisappear {
//                        viewModel.mpc?.invalidate()
//                    }
        }
    }
}

#Preview {
    ContentView()
}
