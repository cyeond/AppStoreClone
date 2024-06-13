//
//  ColorProvider.swift
//  
//
//  Created by YD on 6/13/24.
//

import UIKit

public struct ColorProvider {
    public static var background: UIColor {
        return UIColor(named: "background", in: .module, compatibleWith: nil) ?? .white
    }
    
    public static var text: UIColor {
        return UIColor(named: "text", in: .module, compatibleWith: nil) ?? .white
    }
}
