//
//  CouponInteractionView.swift
//  NIN_SwiftUI
//
//  Created by Soop on 6/4/25.
//

import SwiftUI

struct CouponInteractionView: View {
    
    var viewModel: CouponViewModel
    
    var body: some View {
        Text("\(String(describing: viewModel.distance))")
            .onAppear {
                print("viewmodel-startNI")
                viewModel.startNI()
            }
    }
        
}

#Preview {
    CouponInteractionView(viewModel: CouponViewModel(selectedCoupon: .stub01))
}
