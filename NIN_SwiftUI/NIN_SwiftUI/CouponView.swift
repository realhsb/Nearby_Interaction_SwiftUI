//
//  CouponView.swift
//  NIN_SwiftUI
//
//  Created by Soop on 5/28/25.
//

import SwiftUI

struct CouponView: View {
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 100)
                
                RoundedRectangle(cornerRadius: 10)
            }
            .foregroundStyle(.white)
            .shadow(radius: 10)
            
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 100)

                RoundedRectangle(cornerRadius: 10)
            }
            .foregroundStyle(.white)
            

        }
        .padding(30)
    }
}

#Preview {
    CouponView()
}
