//
//  FontBook.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

enum FontBook: String {
    case standard = "AvenirNextLTPro-Regular" //"Montserrat-Light"
    case bold     = "AvenirNextLTPro-Demi" //"Montserrat-Medium"
    case medium   = "AvenirNextLTPro-Medium"
    case bebas    = "BEBAS__"
    case light
    
    func custom(size: CGFloat) -> UIFont {
        switch self {
        case .light : return UIFont.systemFont(ofSize: size, weight: .light)
        case .bold  : return UIFont.systemFont(ofSize: size, weight: .semibold)
        case .medium: return UIFont.systemFont(ofSize: size, weight: .medium)
        default     : return UIFont.systemFont(ofSize: size)
        }
    }
    
    func small() -> UIFont{
        switch self {
        case .light : return UIFont.systemFont(ofSize: 12, weight: .light)
        case .bold  : return UIFont.boldSystemFont(ofSize: 12)
        case .medium: return UIFont.systemFont(ofSize: 12, weight: .medium)
        default : return UIFont.systemFont(ofSize: 12)
        }
    }
    
    func regular() -> UIFont {
        switch self {
        case .light : return UIFont.systemFont(ofSize: 14, weight: .light)
        case .bold  : return UIFont.boldSystemFont(ofSize: 14)
        case .medium: return UIFont.systemFont(ofSize: 14, weight: .medium)
        default     : return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func large() ->UIFont {
        switch self {
        case .light : return UIFont.systemFont(ofSize: 16, weight: .light)
        case .bold  : return UIFont.boldSystemFont(ofSize: 16)
        case .medium: return UIFont.systemFont(ofSize: 16, weight: .medium)
        default     : return UIFont.systemFont(ofSize: 16)
        }
    }
}
