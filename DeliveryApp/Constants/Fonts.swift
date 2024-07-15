//
//  Fonts.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 11/07/24.
//

import UIKit

enum Fonts {
    case regular(size: CGFloat)
    case medium(size: CGFloat)
    case semiBold(size: CGFloat)
    case bold(size: CGFloat)
    
    var weight: UIFont {
        switch self {
        case .regular(let size):
            return UIFont(name: "Inter-Regular", size: size) ?? .systemFont(ofSize: size)
        case .medium(size: let size):
            return UIFont(name: "Inter-Medium", size: size) ?? .systemFont(ofSize: size)
        case .semiBold(size: let size):
            return UIFont(name: "Inter-SemiBold", size: size) ?? .systemFont(ofSize: size)
        case .bold(size: let size):
            return UIFont(name: "Inter-Bold", size: size) ?? .systemFont(ofSize: size)
        }
    }
}
