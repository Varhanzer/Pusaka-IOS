//
//  UIColor.swift
//  Pusaka
//
//  Created by Steven Bong on 23/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct custom {
        static var primary: UIColor {
            return "#352567".hexToUIColor()
        }
        static var pink: UIColor {
            return "#E67BA9".hexToUIColor()
        }
        static var lightBlue: UIColor {
            return "#58B2B5".hexToUIColor()
        }
        static var magenta: UIColor {
            return "#ED7366".hexToUIColor()
        }
        static var orange: UIColor {
            return "#F5C142".hexToUIColor()
        }
        static var lightViolet: UIColor {
            return "585492".hexToUIColor()
        }
    }
    
}
