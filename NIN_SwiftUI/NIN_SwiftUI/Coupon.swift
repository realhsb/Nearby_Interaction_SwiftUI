//
//  Coupon.swift
//  NIN_SwiftUI
//
//  Created by Soop on 5/28/25.
//

import Foundation

struct Coupon: Identifiable {
    var id: String = UUID().uuidString
    var couponId: String
    var title: String
    var content: String
}

extension Coupon {
    public static var stub01: Coupon = .init(couponId: "11111111", title: "쿠폰01", content: "쿠폰01입니다.")
    public static var stub02: Coupon = .init(couponId: "22222222", title: "쿠폰02", content: "쿠폰02입니다.")
    public static var stub03: Coupon = .init(couponId: "33333333", title: "쿠폰03", content: "쿠폰03입니다.")
    public static var stub04: Coupon = .init(couponId: "44444444", title: "쿠폰04", content: "쿠폰04입니다.")
    public static var stub05: Coupon = .init(couponId: "55555555", title: "쿠폰05", content: "쿠폰05입니다.")
}
